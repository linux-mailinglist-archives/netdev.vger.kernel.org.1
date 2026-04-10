Return-Path: <netdev+bounces-277321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APm/N2rN2GktiQgAu9opvQ
	(envelope-from <netdev+bounces-277321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 12:14:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 778793D57F4
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 12:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95A1F30455DE
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 10:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F4E3815DF;
	Fri, 10 Apr 2026 10:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhHQgAe0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0779A1AF0BB
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 10:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775815978; cv=none; b=iGAj6Z6/tNTcHJTgYq0HQy5Ew2o1+nxwBWnyrw5v+WOHj8O29SkpMoA19cdcdSciGVvQ+NAc9TVzVn4Ua1hfQnfzmrhVM7rVXStfcXm+8hPP4f9il0oIWz9O7WJgbhjCdkvSsHV5JIMxeVIm9h/XcK5t57Ocs+s71PiSS0XVaWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775815978; c=relaxed/simple;
	bh=ZfMymF+VaXCC/l3q7jg/3c/dKpgnkElsiZJqFyIpeeI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qFb2+1iHo+4rSnYlTgXwQwNur21CgOT41sQu0Hj3E/TwRgjtH4+4Z9byTUvbbmyKNX8NB2P426EphqFI6xO8RG4CZtRbKO2Jrq9TyFy1sW6HuXCDi61V1PCjOB5h/uk0Zfw+nPWf3/PjdAXBVLEHiqmACK65k2IFTWdHqCYVmis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhHQgAe0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488d2079582so15389195e9.2
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 03:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775815975; x=1776420775; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kcVFQ5MHqGhOHGxcCXKdm4eAn0531/SxvYTJK8BCQjU=;
        b=BhHQgAe0xLE33iz65wS1enV1IvALynN5dpoIyltUpFNI/ImS6DZX8BtNb5ilaYPU7I
         V42iqNZ2IXYgkAX/YfrZARWhVbGpNlVjCqbDl6IzS0a22qFD8G/BKlT/Bu+Wp9TbGw5p
         ewRiBzg5A3dBqHFtFEVdwUhi7cOfKRPGooxikmP8byPK+z2uY41BHbVJsmsdL2sidUDW
         pAgXCkx2YbRrGFukWDZJjjHuHg/BVgrkpk0bvHJktDorR2gZRLuW5POx812q1M9LKTvn
         ZknVes3sWTZLkefgjjAd66qQqcmu6zGVtVIiv7BQUwKMbQRhj2luOLVGalYgjiGXWPz2
         jAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775815975; x=1776420775;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kcVFQ5MHqGhOHGxcCXKdm4eAn0531/SxvYTJK8BCQjU=;
        b=PUuUF6yE/3PnkoFpQ27Or+NOv5aLBTJ+CrFnbfNlkLZWAUrgn8lLj6G/zboNauFQuY
         aTZhKsmv1I+pwePJEJVm8frp8WLewkWlj9ZggG9hXnONwRtcOqyXgddWqHvVl2YN09tD
         Izmu8qZseQjkFJvqrfQUL4nOX0qmkx9EZ5702587/asUmhtf+UBRIDQgPFWhv06pPayO
         A2xNGFCxBri1A3R+0kkK5f3MQTqToM4k+KCLzco8lec1xlgsE8EgW2RTq2nGYAXSwqNB
         1fMBiQjsNFzmSGojCI70v+uPp84nwNg6eIFaBVZIzuvce3WNz73lcmgxTsC8QRTeNHiE
         pk5g==
X-Gm-Message-State: AOJu0Yx8wcccV6ZbeA2BUt8mgOaE3p3R+1F911xCHP7o6wHCeZScorBG
	srVdF7gJkFUhmtK5ThoNY/j1kX8BK70zHda5tLyl5UMKejvFyI2ss1H5
X-Gm-Gg: AeBDieu/kFRP4+CD0eL8hrWh+NTuZzMBu3ckOGl6a/CAMIpBUEMkiGSXvPJbX9luHv5
	ZUkXXko5US2olUChdQeYjCk7tAbbyodsvyVwb8JGqz3eoFGK+s8I5QkD5fBJkzwVNpYWQw/tspa
	C69BhgSYX//PvM6Rekb3AWH81VIZzAlBgZP7/odI/W4a2kIZVrcpze35UoSAU3sKxBRirKNxUXS
	6RzRgQkMeH89jGYgvACeFFDodCzjKUeXRCTnarfeN6fp8Uf0wI/aORKDRGHdpz4+/wetcR2Orom
	9QMV3TqFRVzC8llf2J6cgx5VYx5keIBW6fCBCLb9Lp2BjM5yeB/S5IRbEg6nhZkhzapGM4uTpmr
	K4jaJdyT5oIc0tbO2KnnvtrK5BtWBUhtR4yPskQ7RRCuOAixwqFoC34bpBHl96CvZgLO7/qRNet
	vFO+5cFPwP3YbPhQDi5nQ=
X-Received: by 2002:a05:600c:8b2f:b0:487:1520:d107 with SMTP id 5b1f17b1804b1-488d688da37mr30167305e9.31.1775815975334;
        Fri, 10 Apr 2026 03:12:55 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d592db30sm54789955e9.10.2026.04.10.03.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:12:54 -0700 (PDT)
Date: Fri, 10 Apr 2026 13:12:52 +0300
From: Dan Carpenter <error27@gmail.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org
Subject: [bug report] octeontx2-af: npc: cn20k: virtual index support
Message-ID: <adjNJEpILRZATB2N@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277321-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,stanley.mountain:mid]
X-Rspamd-Queue-Id: 778793D57F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Ratheesh Kannoth,

Commit 645c6e3c1999 ("octeontx2-af: npc: cn20k: virtual index
support") from Feb 24, 2026 (linux-next), leads to the following
Smatch static checker warning:

	drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c:3534 npc_defrag_alloc_free_slots()
	warn: missing error code 'rc'

drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
    3479 static int npc_defrag_alloc_free_slots(struct rvu *rvu,
    3480                                        struct npc_defrag_node *f,
    3481                                        int cnt, u16 *save)
    3482 {
    3483         int alloc_cnt1, alloc_cnt2;
    3484         struct npc_subbank *sb;
    3485         int rc, sb_off, i;
    3486         bool deleted;
    3487 
    3488         sb = &npc_priv.sb[f->idx];
    3489 
    3490         alloc_cnt1 = 0;
    3491         alloc_cnt2 = 0;
    3492 
    3493         rc = __npc_subbank_alloc(rvu, sb,
    3494                                  NPC_MCAM_KEY_X2, sb->b0b,
    3495                                  sb->b0t,
    3496                                  NPC_MCAM_LOWER_PRIO,
    3497                                  false, cnt, save, cnt, true,
    3498                                  &alloc_cnt1);
    3499         if (alloc_cnt1 < cnt) {
    3500                 rc = __npc_subbank_alloc(rvu, sb,
    3501                                          NPC_MCAM_KEY_X2, sb->b1b,
    3502                                          sb->b1t,
    3503                                          NPC_MCAM_LOWER_PRIO,
    3504                                          false, cnt - alloc_cnt1,
    3505                                          save + alloc_cnt1,
    3506                                          cnt - alloc_cnt1,
    3507                                          true, &alloc_cnt2);
    3508         }
    3509 
    3510         if (alloc_cnt1 + alloc_cnt2 != cnt) {
    3511                 dev_err(rvu->dev,
    3512                         "%s: Failed to alloc cnt=%u alloc_cnt1=%u alloc_cnt2=%u\n",
    3513                         __func__, cnt, alloc_cnt1, alloc_cnt2);
    3514                 goto fail_free_alloc;
    3515         }
    3516         return 0;
    3517 
    3518 fail_free_alloc:
    3519         for (i = 0; i < alloc_cnt1 + alloc_cnt2; i++) {
    3520                 rc =  npc_mcam_idx_2_subbank_idx(rvu, save[i],
    3521                                                  &sb, &sb_off);
    3522                 if (rc) {
    3523                         dev_err(rvu->dev,
    3524                                 "%s: Error to find subbank for mcam idx=%u\n",
    3525                                 __func__, save[i]);
    3526                         break;
    3527                 }
    3528 
    3529                 deleted = __npc_subbank_free(rvu, sb, sb_off);
    3530                 if (!deleted) {
    3531                         dev_err(rvu->dev,
    3532                                 "%s: Error to free mcam idx=%u\n",
    3533                                 __func__, save[i]);
--> 3534                         break;

Set an error code here?

    3535                 }
    3536         }
    3537 
    3538         return rc;
    3539 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter

