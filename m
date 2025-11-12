Return-Path: <netdev+bounces-237926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E640C51905
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 11:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C98184F1095
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 10:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2936A288537;
	Wed, 12 Nov 2025 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PwRTX4vK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sEgEXPWs"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2BB2F7AA2
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762941828; cv=none; b=bBna3U2nL5K29zz6skxAkXZeH6JlfJbZ7AhNKzsGcKNK+E17SdPzb8p9p86UEUXQZ/agMZvnZEvgU7GWc51u/SsEQhG69SMGOF36cZ+UQC1LkezA3YoIXheisvQRyhGwyLmUiWqNok44j9RBXVoWQx8bopeVg+G2MiaUuWows3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762941828; c=relaxed/simple;
	bh=Poi87yrbG7PSvrTYPMhWGuxHOf1NNP1dJzgvg3eqXQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTRY48xmO3ALiw6JeAD86CiJgSE5Kzous1UJw2ZAVT2svHYLrMPGJi5nPzABkd1xBYa4mprkbCDXxUbxaI6csAsrGF8xJANCKEziwIqBRsh1L2niwRbUMrl+pZnFVYWYnYP9jJvvTS6H4i+XGyta1wfSn8DGZ0kxerQRBw9KXdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PwRTX4vK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sEgEXPWs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Nov 2025 11:03:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762941825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eN2sI9FTwS2DD5Tq0n11lJxcWurFq6v4PgvVaxhoJr8=;
	b=PwRTX4vK4ZWy7DcEssvn9vnDzqFXHeSXCYrY7sBbytpbiD2jpl/yHwh7R9ILQRs1yDY3kn
	ln37VHEPoNrYGVEiskmWH7GyrFRyPTy+9XrLWo++IEBFJxJ+mGdWPm7VF+hMgcOhn+qIPA
	vv/3V11hCpjK2+Mgvyymfojv2G/tKsCpRauMPQepaQQ5rWcOK8Ccbrk9sTF39uJ5TZkjrU
	w2J8JjciFlB1XN2w1W8ir6KKoRB1VsswiJQro3AKxcSn25owxduHJn48gG7NHvAheeH98t
	K91zwyXQC+AjNTitUgxs0OTgvobMDrM6UfjvTLp7OKbNlFB5FeDdCV/Yjjub/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762941825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eN2sI9FTwS2DD5Tq0n11lJxcWurFq6v4PgvVaxhoJr8=;
	b=sEgEXPWsU0WXBE/Vd9NV/qrTXuMc2nKqYpEYATlUOOHdpHUM43QW1l+Pd89gztj1kYIgy0
	bPG1h0rO+e00JMCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	liuhangbin@gmail.com, m-karicheri2@ti.com, arvid.brodin@alten.se
Subject: Re: [PATCH net 1/2] hsr: Fix supervision frame sending on HSRv0
Message-ID: <20251112100343.9biqchIs@linutronix.de>
References: <cover.1762876095.git.fmaurer@redhat.com>
 <4354114fea9a642fe71f49aeeb6c6159d1d61840.1762876095.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4354114fea9a642fe71f49aeeb6c6159d1d61840.1762876095.git.fmaurer@redhat.com>

On 2025-11-11 17:29:32 [+0100], Felix Maurer wrote:
> On HSRv0, no supervision frames were sent. The supervison frames were
> generated successfully, but failed the check for a sufficiently long mac
> header, i.e., at least sizeof(struct hsr_ethhdr), in hsr_fill_frame_info()
> because the mac header only contained the ethernet header.
> 
> Fix this by including the HSR header in the mac header when generating HSR
> supervision frames. Note that the mac header now also includes the TLV
> fields. This matches how we set the headers on rx and also the size of
> struct hsrv0_ethhdr_sp.
> 
> Reported-by: Hangbin Liu <liuhangbin@gmail.com>
> Closes: https://lore.kernel.org/netdev/aMONxDXkzBZZRfE5@fedora/
> Fixes: 9cfb5e7f0ded ("net: hsr: fix hsr_init_sk() vs network/transport headers.")
> Signed-off-by: Felix Maurer <fmaurer@redhat.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian


