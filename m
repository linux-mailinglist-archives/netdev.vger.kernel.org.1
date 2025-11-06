Return-Path: <netdev+bounces-236459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC113C3C8A4
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 17:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A185B563E57
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 16:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B962234F244;
	Thu,  6 Nov 2025 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hT2JW1yy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919C334EF09;
	Thu,  6 Nov 2025 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446838; cv=none; b=jc7c7baKFc81N2QhGulhxtO1MxFIU0d5LAN+hbcu19ei/lRGvMnCGVn1MsxGxj1innwe73CkmepIMxxIhINO8N9W9OWtLAYfJuqxJEnXoafw/RB5nvHfPvNYCPNZaoj0hb/HeAPbS3scRaUee4odDJU7wFS4R9cte2LIT9NMaUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446838; c=relaxed/simple;
	bh=23RIkp7485ZkXB8hdFp+dC63HcoB9hT6OEoJrD83jDs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iTnoc+kuZv2WcY1ImUz9uEWtvEhHKk6x0DK5XLYZjJZsXFpd88wqrSAS8MaV7/J/ZfAuuSshTzE8sF30A/Ih14ll/PtMR6U30c+UxzYdTBUFC8lGLMrBhUKfmrJauUWp1F+3PNTbk/SM2epoU4JkqMDTyvGow/Vj/Fmi2e7fgqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hT2JW1yy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7478C4CEF7;
	Thu,  6 Nov 2025 16:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762446838;
	bh=23RIkp7485ZkXB8hdFp+dC63HcoB9hT6OEoJrD83jDs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hT2JW1yywVCTyZyPCJaSLTCDt6Z6xmTElp0d7Rus0UWCknUYzWr8MuljhMfyAZg8l
	 sufyD80G/8NjjHwYEiYKB5+yeOtLdq5degpSIUZD29ZSf66sgyJYv+0cKbTRTkvfNm
	 yT1T8HHiwv1AVx8gDhLfN7WYczMrDdxGiTqJTogLuO72bENunxQGMYpGhW8O6Mk4z2
	 TChbcSbWixqKePs57tiyEV01EyHK2NaAwupkR7we/aFsEHClvfCKmWZxoa0o1ptri/
	 zRe6WfgR/Af1k+CkddHcAJwhgRYx2cqZomPAbJOjlQtDfaaqbNeJ05gOsYQ5F4AN84
	 EU43PDn/43GNQ==
Date: Thu, 6 Nov 2025 08:33:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com
Subject: Re: [GIT PULL] Networking for v6.17
Message-ID: <20251106083356.533e52a1@kernel.org>
In-Reply-To: <20251106163252.4143775-1-kuba@kernel.org>
References: <20251106163252.4143775-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Nov 2025 08:32:52 -0800 Jakub Kicinski wrote:
> Subject: [GIT PULL] Networking for v6.17

Damn. Sent the wrong file.. sorry.

