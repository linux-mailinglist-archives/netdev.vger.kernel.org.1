Return-Path: <netdev+bounces-281898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDj9CRXE8GloYQEAu9opvQ
	(envelope-from <netdev+bounces-281898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:28:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9473F486F59
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6510731123CE
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C3442188F;
	Tue, 28 Apr 2026 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pi5cKqt5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9596D3F23B1
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777384195; cv=none; b=C84UmSaEVID9CTgs5C4yW6zDQqYTbR15UuEwcdIy2GwIRxwSjCmaylVQtRFiqH8fDzII4u/FgXc5TbdTAc9DdFJR171z1y3zYUUYJDkQVTTcGc4QK7u0OPhM6N6IQh/XoSgBH7hQi6mHpqoj1fxSONByVNPjXI3ki2JmcgloonI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777384195; c=relaxed/simple;
	bh=i+nKcGjkS/5Tczt523KayzkEsOUyVHbiSfY3f11u3hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2J+vKbo+e6fsGiivjcrAfmtf26BDNJhNpJN8q3uJtoQuKJRbN7TcJesQjsmk38bn4pC60TIii4aN40+e7dGKNmSONicFjXn21l/Gom9bFDvhdXxWZu2KG0JqGJ6qNt9+magy+G6U48lLQUycspiORUNX4OC+cJa1JRKWNoVcFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pi5cKqt5; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d64313c39so8868698f8f.3
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 06:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777384193; x=1777988993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yMSrgBhN+mHfZpVt9bh3H6mTLY0wCmlOX7rIndgq/38=;
        b=pi5cKqt5VZ8OyWIWcOqAL4vWNV+C9+vbi7mV/wrjeeKIQnHC35ispLokP6YULp4fku
         vvEOg+H25XSVtwtW60Ox89K181iaxz1fyx2WDZYl5vKSWjBd13XGbU6ngp7Kmzm/o/ln
         15tizZCKOI2nAEn1pVo4c+KuOQ5XkLFm+pZY7GCHnuZWytnI8E6GSMa0YRNhsddDN+SS
         ZEmfK4OghiZOPOWiC816YeM3rcqh5lM7cWsKzz4ekGQRjknLJds6DTfe+OClK+xois0f
         NpgPSh/mlI5HBZsaV/grbUewvzQf6QKGWoZCvbCS+BaxD329jub02EXkcLFTjVuWiS03
         weLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777384193; x=1777988993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMSrgBhN+mHfZpVt9bh3H6mTLY0wCmlOX7rIndgq/38=;
        b=TEurOd0c1ede15b09K5zjJFRQb+aKNTY50Zp1Vte9SIUAkurgRsYf+jmLJ0x5k3xq6
         ACCTbWmIwJOWJhOigNx2GEcpc+nruwdysXXvO+dccFalLny+XuAmr+ob/SeGIThN7070
         Pil0hLWO98f0J3T6wT0ESuO8/mTdR+FVWdX0ab1t70JZlqhHuQKoRNimsUtLuQOEzaUO
         aCeNFyF485wvoMeoOgfN3c6Sx/xQ6FiJEjDJSTtspRPDa1QdaPfYCwmht+u3dS004DQL
         bj/ae6vbZUQuunfU3eEKwB+3cLbPdN6YdsFuVhUCohIhyfelqLK+5mSJYQ5BQggDfixp
         f+lw==
X-Forwarded-Encrypted: i=1; AFNElJ+Zty/ar9iMnYyJyly0cFcPu32BFCPGcMFVA8zsR37v4SLzFmCJwDThLGlzQSiyHaxcjMtyCVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzId7u2LDfS0wC6IA+DKST2/bCwUkAFN/eM3HxY7Kz8xjiUkwsn
	pbEnoGf7z5BE+TQNQiqjX3hRj3wLN5hJHBBxzW6O3YWK7KE3Sdov7+PV
X-Gm-Gg: AeBDievA2fGAhz9AbJrt15xwpZx4NKWqh1RTRtzYXnS0XMnOYrGBYg8Z68EJseeWfE/
	CGIe7E/eAUJzBvR6MH37S1qM9d/s0LAEZWz9/iA5He8X/04E5ZZddmyC/7di8fXLrQ8C2kiHDfP
	jKVTC2vmJU2li+ckTWseu37bQT4Wcz412GUD6RW58p6feQtoYqJsBdCpIRuMkZ9N++qWHjIaB0v
	AFznE2tImnWmrxmfH0KWetzmiDryHFulIgOXROZMtJrJ+7Q2UtXvPSH9geh1phWG6GZLlgkAskY
	8TU+JhbX+XqPcVjLBv8uVFpLhQxu+InE2MYq/5GmiV5HDC2KSnkPegw44nx3PHXq/lR9ZWxmGaO
	fm1tWX6IccHe/LNjZp1rBk6euE2fqlEo0PZA9IWNNvHG18jLxvgrcN+6SER4oYEaHtpOfdR4SpI
	dGLaOCqfQlegMpOWSy+XTCgd8monbNRg==
X-Received: by 2002:a5d:5f96:0:b0:43f:e413:e5ad with SMTP id ffacd0b85a97d-446448b87f3mr5644612f8f.0.1777384192756;
        Tue, 28 Apr 2026 06:49:52 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463f994a3fsm6535789f8f.25.2026.04.28.06.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:49:52 -0700 (PDT)
Date: Tue, 28 Apr 2026 16:49:48 +0300
From: Dan Carpenter <error27@gmail.com>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Alejandro Lucero <alejandro.lucero-palau@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Martin Habets <habetsm.xilinx@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	linux-net-drivers@amd.com, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] sfc: fix error code in
 efx_devlink_info_running_versions()
Message-ID: <afC6_N4cCewJrkis@stanley.mountain>
References: <aeyEzO6C-v6J1VHH@stanley.mountain>
 <0dd0c884-c846-4f17-986d-fb24b21a836f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dd0c884-c846-4f17-986d-fb24b21a836f@gmail.com>
X-Rspamd-Queue-Id: 9473F486F59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281898-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[amd.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,stanley.mountain:mid]

On Tue, Apr 28, 2026 at 02:36:55PM +0100, Edward Cree wrote:
> On 25/04/2026 10:09, Dan Carpenter wrote:
> > Return -EINVAL if efx_mcdi_rpc() doesn't return enough space.
> > 
> > Fixes: 14743ddd2495 ("sfc: add devlink info support for ef100")
> > Signed-off-by: Dan Carpenter <error27@gmail.com>
> > ---
> >  drivers/net/ethernet/sfc/efx_devlink.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/sfc/efx_devlink.c b/drivers/net/ethernet/sfc/efx_devlink.c
> > index d842c60dfc10..45f412bb9b5d 100644
> > --- a/drivers/net/ethernet/sfc/efx_devlink.c
> > +++ b/drivers/net/ethernet/sfc/efx_devlink.c
> > @@ -531,7 +531,7 @@ static int efx_devlink_info_running_versions(struct efx_nic *efx,
> >  	if (rc || outlength < MC_CMD_GET_VERSION_OUT_LEN) {
> >  		netif_err(efx, drv, efx->net_dev,
> >  			  "mcdi MC_CMD_GET_VERSION failed\n");
> > -		return rc;
> > +		return rc ?: -EINVAL;
> >  	}
> >  
> >  	/* Handle previous output */
> 
> Usual practice in sfc is to use -EIO for 'MC response was too short'; it
>  signifies misbehaviour from the hardware, not any invalid input argument
>  as -EINVAL would suggest.
> Other than that, looks fine.

Sure, I'll send a v2.

regards,
dan carpenter


