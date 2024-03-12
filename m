Return-Path: <netdev+bounces-79514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C823E879A84
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 18:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83CD42831C2
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 17:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB3A137C5A;
	Tue, 12 Mar 2024 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZAZzHsC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6067D409
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263925; cv=none; b=f393F8pB9EonZOaqBfJ5P2FRf4ulIpn38KXNl2L1fVJgDF30F/TCtaM7u7Bb2sXKJqCHBwjtKpFFmJQ6FQCGMV3WgObtbSY8uvmtEUfUPykRzlixZkblFqKBVibY6FM3Y2HaLVLqD+g1ynUFw5wPN0JgR+zG4cHNJGMaLSt/+O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263925; c=relaxed/simple;
	bh=59e8XOEgURT+yN7LujIPZkyV0bQVVLC9oroDL0VptYw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=khKmieqXnrF5yYjQ1rRu3TLAztSuRv9wi1jVezS6fSkVe4A3DJBWFamxNJ3LyEfEjWY2T05kfBXavesib9zu47vXiDuHZtYoquIbrJWO1qVB3eZxWfVRJqwQ1GEGtb/gIcI0Hf6EUP5U9kCD2vDtrgxwVjslGoRxHAg0c96gxv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZAZzHsC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D46C433C7;
	Tue, 12 Mar 2024 17:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710263925;
	bh=59e8XOEgURT+yN7LujIPZkyV0bQVVLC9oroDL0VptYw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WZAZzHsCIN74ueL6m1CPKNvYg6gjCwbbl80ynzo3ukMldl5huv7JdLZxkW7lscF1u
	 6vQx3XuHi77toElkKw0V6RbpyaiTbdMaomOlOUAcz/Atairy33pd8TPEe4vVzSGDUC
	 xRaI9B5GuSjMJSRg/xMj+C1RY4JLRnOZEa+SxvqwsU3CpkkG/OX/4FQjMPxCF1dztv
	 aeUZguTupoyZNH9exnEIByTcIdrvue8Qw7YNz0nRm1D1kBmXtJ3L4B3DpMUVvVRt6i
	 70Kz4ot/uMmjzug5XR/gah6Pf1Rq4QDSPifA0CrK4cyyaBPzCkkv40Povy1qSUVqCn
	 lAKrZagzF/zag==
Date: Tue, 12 Mar 2024 10:18:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: William Tu <witu@nvidia.com>
Cc: <netdev@vger.kernel.org>, <jiri@nvidia.com>, <bodong@nvidia.com>
Subject: Re: [PATCH v2 net-next] Documentation: Add documentation for
 eswitch attribute
Message-ID: <20240312101843.36ad2e95@kernel.org>
In-Reply-To: <20240312142055.70610-1-witu@nvidia.com>
References: <20240312142055.70610-1-witu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Mar 2024 16:20:55 +0200 William Tu wrote:
> Provide devlink documentation for three eswitch attributes:
> mode, inline-mode, and encap-mode.
> 
> Signed-off-by: William Tu <witu@nvidia.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

