Return-Path: <netdev+bounces-279170-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ugf5KV9b4WmusQAAu9opvQ
	(envelope-from <netdev+bounces-279170-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 23:57:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B66415206
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 23:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC885306EC45
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 21:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974CF390218;
	Thu, 16 Apr 2026 21:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diofJIMe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3E9371D15
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 21:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776376482; cv=none; b=MmaNi9TbS45NwMP3bzrZRLEm3r1sVBnFm/GOapFb5YPUe+VchP8567wReYPSFlcDrcqlC9Ey7LcDPuTn8JAwvkKts4gNT94D3/C93mvFgCdSnohJfY4RbWWq37f9hcps9Q1XC32NGGUzElBG9he+PlZHA52kTA4WdhlV8Xgeles=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776376482; c=relaxed/simple;
	bh=Cy6Nfnfi+P8iX9g7jNh19cVxNF8CkAafEy+lOjd5iFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNwhOYxTIq70HLmsjbU6z9w2mRMctWf+U5WgKR3tE5TpeoOfMv3AdnLWdj1qPSxGudVP+MoB3VBl0fFiKFI9b2PbMz1q51SSSbT7RvWpmERmTmPFL1QHbH05RPMCe+7aKf8ZDlxOj6kkTmecg2VvV42ajdXxE/bXmzHo3PtsbXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=diofJIMe; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82f1bfc9b8fso24550b3a.1
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 14:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776376480; x=1776981280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JxrR95B6yVnEMSSdGvsY4facZH188kLZA69tYhhuh5c=;
        b=diofJIMe0h38jEBKzeHvibs2d808M4/LlddQF9/t90SMb2NvxJM9smrQP30doLCk6h
         qSZMrNtGr0nnqUFehl+TKTGswlVkgtBQFAMlaXKcQ+6yW8OXsGqLQ6W5Ik8EhrcySvXu
         DraWXJRGsjvhWzjspIGzWZRRX1pguYOU8q0Qtl7KnKCPd24+tOVUtX5yBovHuQNlXDgj
         nPYqqCMa4dhHiH2azLtl/XSusCmAjeM+yQtPXnGZaQrLbZ0kFXWjEaPKVafjs/IFWSGl
         6Df2jwuvBKUz+7j3yAplfGfMEQtEXWGiUSH+ThRwqIxy97IgFEYr7N2LWvBE7zec4zPD
         uo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776376480; x=1776981280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxrR95B6yVnEMSSdGvsY4facZH188kLZA69tYhhuh5c=;
        b=Xmb/yz2UtmpoWwulxUfLinTyyj+9DhApirRcRdQeQ4HpfNuEhKq1LGyfgA2W20dGOA
         3rf/9/6nSNaaHtVXtbvvh03ci/PpETcQgtoyllREpfahuuuMTQb1XFJEuFQMUKuY/tL8
         HjStQ80H99ToCWNF80QV1MtygZBiw5SJvOt6+DnD+0Fnmc3MbCmTDMVWhyVTH4L0QluR
         03+W5QGb9JeOVr1DaYoNcWsq68yZ9RDDh+70GmFXjPYSjwPWIoAmW8zUnPMOdiHry4B/
         BmwU1eWOJN+ZY6wOuJ17MNSj23yacmOpbI0xJefdpAKJWMhJ6cbL65HVoziN9DUSUarf
         VfUw==
X-Forwarded-Encrypted: i=1; AFNElJ8T95YBrh5DWynbtnlDFnafoqyhCvbEwaGar+Olbb3JCVZnTm5jujMFMHsZZB+u/cniy82mUGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe2m3b+Jwp8/BcRs7U+YiiX7BF2MOePuVdicgiRXYY+clB3s2n
	9faXJyktU1yztQ9/VShMOVd5+lfZIWljb/KvIoCsg+lpWqf5+q5+QUET
X-Gm-Gg: AeBDietkXtwSiyDaEFsEkgMW/xpHK0mm3mKk+jm2PLaD9aCGRJp+K1zBBQ91DEVqowy
	JtcuZ+z2EX4YwFGRCvQX2gRv7gGEYiS6D5F4lK05Q7KURPYvktnBKmML1wEwcFpig+URLoKOrTm
	Md9CuFqcT82Um/QRKzjU8w4uihq7qcFhSzHi+OBmBV392fGCk6IBz5lvRlskOY3OzPOxdukvofD
	OfbBTOTePzpbV+yNQKKzN4UzJWKvIYEfKKgGLQkNiRyA00ITSNilqQZQ5ZmTH1GXEsHaC1u3VtU
	ObMKKihngNhp+L+7sISuAPEnKbLlqnXmTrUnw8yKemtut/WRS3OkEKXfqFHiqeX+UNkHzqprM6y
	osFDZp2CUvaBi4H1qF7abrFSGqgoOV3ODNf36kM8wZ9tnyviXsjPJ9JQc/ltc+d/weNZsllx7RR
	Dp4Wn5W7a1HFCWpeNhqeiivYR6TZLecUXeM4CywP/UlPqMWRSlezju6Bbc8sQzFAvCwA==
X-Received: by 2002:a05:6a00:3e07:b0:82f:29fe:7239 with SMTP id d2e1a72fcca58-82f8c93aa0amr11326b3a.50.1776376480513;
        Thu, 16 Apr 2026 14:54:40 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f67449c3asm6315498b3a.53.2026.04.16.14.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 14:54:39 -0700 (PDT)
Date: Thu, 16 Apr 2026 14:54:35 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net] eth: fbnic: fix double-free of PCS on phylink
 creation failure
Message-ID: <aeFam/KxhZSMl6xq@devvm29614.prn0.facebook.com>
References: <20260416-fbnic-pcs-fix-v1-1-ac4b6badeac0@meta.com>
 <1873b5ba-419f-4247-ab92-1b5e899458e8@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1873b5ba-419f-4247-ab92-1b5e899458e8@lunn.ch>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-279170-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05B66415206
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 11:00:01PM +0200, Andrew Lunn wrote:
> On Thu, Apr 16, 2026 at 12:31:39PM -0700, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > fbnic_phylink_create() stores the newly allocated PCS in fbn->pcs before
> > calling phylink_create(). When phylink_create() fails the error path
> > calls xpcs_destroy_pcs(pcs) to release the PCS, but neglects to clear
> > fbn->pcs.
> > 
> > The caller, fbnic_netdev_alloc(), responds to the failure by calling
> > fbnic_netdev_free() which in turn calls fbnic_phylink_destroy().
> 
> Isn't the real problem here? fbnic_phylink_create() failed, and it
> correctly did its cleanup. Because it failed, you should not be
> calling fbnic_phylink_destroy(). You only call the _destroy() if the
> previous _create() was successful.
> 
>     Andrew
> 
> ---
> pw-bot: cr

True, the real issue is the _create/_destroy call asymmetry.

How about something like this (untested)?:

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index e3ca5fcfabef..2a6a73393732 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -818,7 +818,8 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	netif_tx_stop_all_queues(netdev);
 
 	if (fbnic_phylink_create(netdev)) {
-		fbnic_netdev_free(fbd);
+		free_netdev(netdev);
+		fbd->netdev = NULL;
 		return NULL;
 	}
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
index 09c5225111be..50240e6c2ee9 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
@@ -237,6 +237,7 @@ int fbnic_phylink_create(struct net_device *netdev)
 		dev_err(netdev->dev.parent,
 			"Failed to create Phylink interface, err: %d\n", err);
 		xpcs_destroy_pcs(pcs);
+		fbn->pcs = NULL;
 		return err;
 	}
 


I think we still probably want to be NULL-ing the pcs, even if it won't
necessarily matter anymore.

Best,
Bobby

