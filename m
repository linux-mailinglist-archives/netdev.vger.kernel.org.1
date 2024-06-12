Return-Path: <netdev+bounces-102771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5179048B5
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 04:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6E01F23C98
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 02:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462CC4A15;
	Wed, 12 Jun 2024 02:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVi3M4hQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187FF4C90;
	Wed, 12 Jun 2024 02:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718157644; cv=none; b=dtfozTzsvvwAUuibjIq3IaqtrBNOGD9nc+rXqv4Q8kVJMvYpdit9y+Gp66e1HNRedJhrp0aBz3xxjR93AsA5AgajPgJLgAefCC1Kb2u/odFcxh5hyHQ0vV9aDhtuOP734ofJGsFc63yw7yp4A+4lzaudQzpH1fQwHecZBUXvEdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718157644; c=relaxed/simple;
	bh=mRJMZ2W7ZSOuAN7qDB+6TQp0DPutDQlraxyqcpWTtSY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SVmHy1oXfk805XKfkUk3+33lrov9uMqPAYCbnDt0rpPjUXzQMRlZGLc81d3zEh4V6JFeZ154feAva/48HfCqSYVvymaLaKYrgBKW9tBixHtDfpgq4Hk941fVb5HQxl0dn5JY6XJax1HnmVij6iGHUyU1HYChlBvcsxma7E2AUT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVi3M4hQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE671C2BD10;
	Wed, 12 Jun 2024 02:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718157643;
	bh=mRJMZ2W7ZSOuAN7qDB+6TQp0DPutDQlraxyqcpWTtSY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LVi3M4hQSVFcoQOzn2k1u/bqEP8FTLPJN8pcaOTpA2otYbEVj4VnZVvKk4WrdXrim
	 7jSXPbpzVf9tRBBo1riWFL2yILE0Z6wcZ7XDAWGzadJz+HE2NNN7tkS29xpUCjVQgE
	 yNMSdzBPovMw4jQ5In6sqHEfKdO/tbvKy+yoBDH3r0eqm1eb11QgBNY5uqVhx2hny/
	 RKSkSWJSvuzR+iiyF6wmer9YwhIuft8MRp6yac//N5n7/E8D1ODX6PnI6YNR05h4xK
	 zd8/XxM+/lAxDHIR8fh21reGNT/co1wILOiVMskTZ63WlHCUzhS8FSOakFRLLtOKs7
	 9Av6iMABn7Pag==
Date: Tue, 11 Jun 2024 19:00:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Martin Schiller <ms@dev.tdt.de>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 00/12] net: dsa: lantiq_gswip: code
 improvements
Message-ID: <20240611190041.6066d6a8@kernel.org>
In-Reply-To: <20240611135434.3180973-1-ms@dev.tdt.de>
References: <20240611135434.3180973-1-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 15:54:22 +0200 Martin Schiller wrote:
> This patchset for the lantiq_gswip driver is a collection of minor fixes
> and coding improvements by Martin Blumenstingl without any real changes
> in the actual functionality.

For future reference:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr

