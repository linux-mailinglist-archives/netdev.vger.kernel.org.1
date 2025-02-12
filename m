Return-Path: <netdev+bounces-165382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FE1A31C87
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 04:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42ED11882848
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 03:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6259C15383A;
	Wed, 12 Feb 2025 03:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Akw0HM1U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E35BC148
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 03:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739329363; cv=none; b=FFDZza7fInG+/sU6qRNSBWqaOJZH8qqz/azjoTNqCb2fF5oRW9xDVL/wJ7t++FaItF5hnvRhVfJYvlN4r8MuVAcLhWny7jsN8i7SmoXqW+9Cx1eKTtkUm9TDMUZ0i3qR0Fd/rNfsXmZlD7/hQM9S583YklJaq6Cdm3AWiG413bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739329363; c=relaxed/simple;
	bh=vOtXrMZVuVAChfp83EQX9/gKCDpjnIKI1OOcyKNzrOw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I04d9DRDikYki9/sqNaGvky+wTB8aJl02u0pqSwnP2II39yIvIQt6k+KA3D90lwItB19tPbR8z5RzSRsPjqxvVvRlbtB7cA7409d5C19Jh+NCRI0tWTRTOII3diQ6bexIKoL2xnaHWQFS4H+Y746egUdV5zw1P00mOZQNzo0MwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Akw0HM1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A75EC4CEDD;
	Wed, 12 Feb 2025 03:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739329362;
	bh=vOtXrMZVuVAChfp83EQX9/gKCDpjnIKI1OOcyKNzrOw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Akw0HM1Ukvbhu8xCCnlJxpkiVM0Vq9DNAuO4V9i9NvKQvRYN3uP9l4MkGlDaJE8BC
	 WMxl0NklBrhwVL9+cyvdp+8QTC54i0w9Vg0eYa5H/Q6EC5D+WPGSJ2a22LcmGfzi9l
	 /aYmQwn3xWyZZzA8oJhvTSuJwsKj/2HsL1khapC+RW/LXBL0lL2WJYsgFRoKHGYaLk
	 d4iqIwPXsqb+mrGSBRp8Ocf/2hho2sGsm07SLxdpUONaLx1hEj8zNRTr99sBGF0efC
	 Y+JYcEDOdtm9o3liLSluvVXdSI2H5EDpbrqBPoGNoa3QtSIqviHWNkMqRsOvqyqLz7
	 ufxakifqfEAsQ==
Date: Tue, 11 Feb 2025 19:02:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: netdev@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH net-next] net: sfp: add quirk for 2.5G OEM BX SFP
Message-ID: <20250211190241.6c978f6a@kernel.org>
In-Reply-To: <96223803-95a8-4879-8a26-bc13b66a6e6b@birger-koblitz.de>
References: <96223803-95a8-4879-8a26-bc13b66a6e6b@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 9 Feb 2025 12:01:55 +0100 Birger Koblitz wrote:
>    	SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),

The patch is corrupted, there is an extra space at the start
of each context line. Perhaps try resending with git send-email?
Before resending please add Daniel's review tag to the commit message.

>   	SFP_QUIRK_M("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
> +	SFP_QUIRK_M("OEM", "SFP-2.5G-BX10-D", sfp_quirk_2500basex),
> +	SFP_QUIRK_M("OEM", "SFP-2.5G-BX10-U", sfp_quirk_2500basex),
-- 
pw-bot: cr

