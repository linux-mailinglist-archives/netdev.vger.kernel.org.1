Return-Path: <netdev+bounces-277253-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCvoEDSQ2GlGfQgAu9opvQ
	(envelope-from <netdev+bounces-277253-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:52:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2D43D2779
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A5C23011521
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C04318EC5;
	Fri, 10 Apr 2026 05:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXMH2I81"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1288E30BF5C
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 05:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775800365; cv=none; b=f/TmF3pSo51xpDHL1Rx6zMkDX5izq8A02LKsNNQGzVftcmZgRBjATqM8z8N6Xh+7eaMb5VNQEMUcua0ufQeMci2F+fEXqgElk0rwnGiOj8QBNg9puNJnpLLz6D68eOKdfuRladowmuZ37kgEenyJoRq115VClWdNoEak1Rc7TG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775800365; c=relaxed/simple;
	bh=jOrMnUOwvBwjlbxJixNglQdUH6IxJgtmoIal9APnk0I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EWl0OjtccQ2cOVG7O1MuUiSwc2ieYd8d6D5HyF4uKOpQQ2rOyjK94Et5bO7Uo5vFRoAR6ClTOFDYOCkdVWPabJf85oITKuofsH6yrpFbQswVzQmYxzuamYk3Jcik33XJzH6zPfwl15BR54Sffk8XjaEYAcGxg6ABPWCDpyNmvUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXMH2I81; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43ccda008cdso874431f8f.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 22:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775800362; x=1776405162; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6HL3c8AI6LLtjFPcFdJwVliBGJh0YRgS/cUAL+4flsM=;
        b=GXMH2I81Nxhp8YfpkhyBhbF/ooQLIbq2x44AvxBtK19CKF8lzjhnBS2QOsCAnVIa0s
         G/uQMw8JIyIEn+QforkSlBzpa3M40n8dmGhwqlQdgKPtagWct1AwnVWSL1bryVzKmeyO
         SWrYP0PveFf6fbfONPYl51r49AYlhlmDIx33/Csh61TtBSRTnaDnvvLw+s9q0oVP1nis
         qLHC4IYF6AIPLecxHWufjMygVo4xyoMPeAkFtIOOeoRHRTjBGj2I6EwWUhrdAfLCEKRv
         +N1Xa8dKkytPhx0Zuxm6z4ve6KrC62BgjM0/xrz6oTYJpIDodWMzigvWULTE/FxZn0L5
         dpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775800362; x=1776405162;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6HL3c8AI6LLtjFPcFdJwVliBGJh0YRgS/cUAL+4flsM=;
        b=quAsbDFVvmTN806UrwTTToyCV4m40ah3+ZK/+lHqZZaIH4KobfBcqiyUKdfUdgcSYf
         TYF68vR1gqRGirZYNNpTJ/leIA4KJS57W/uLl0YA1trGZfG2dhDPA1dXuDvPbPrI1CDr
         pMsDznbmIF5AUlPrBVbFKH9AvSTHAhaxC2Wk/9/DTF8Ke3fUzaFIp4Tpi0y7L2eNgI4s
         F48VtE+AOyaI+VF0k7Po/WeRQD8Sek6nIeFnrVaiUmCneu8pGi4lKoZGg6xU/YY3VqeJ
         NKip+ZwBT1w7gl5a3G6VnCFAHKg8bO0EFw8ojitb1cPi4+ORSmjon96FwyKmv/B5iJuT
         jHuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWirOTpK0kVW+VMfuYyIyTqv0krQsit9goqHOaoM/YWglDkwLQgqUkMMTMRqT+VqjnuJoNdwdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHS3qrVPjCPdq7gcLGmUdBLwk//rnNeMdIN1cNCnG6ZbcShe4l
	2PifkB+l8gSN7hxGnz1glL+SoLsNy8cOu52yFoT3tSxeegpdnhiLWPiw
X-Gm-Gg: AeBDiesfTuWGATE33y12jj2M/pWKYMEGxDoULB8d2rPQPwXuNmg50fg8J5Wu5CQZYpJ
	x14xGiabeJOepj0lP8Q8n7AcSRfBkm0L4yC0acBwzAJKMLAuoO6xJV50mrJGmBj/3AIrTyo8VyN
	KwWeaaRpRWsKYsvkm6zZzdsPb9wZxjHna8pdMuEhD2eUIvwh7w01yIpiiGYAmcO/GIXwCQCw1Xh
	vNOYp+vAird+Ppvly3uyXr3BgsOfMhJRQ/20CvO1kG/jCaflDAN3OnCEj9LIP67J6ph9lIT9qoL
	MYb9a0uv2J3u1rzyj+DwjOj/eb70FmnwZJKSJlhgcDhf9b24rVeNS3h+ngyFl2Zmk9+/TpxQATD
	P49nve3tqwfkbYzqdCFkTIwaGbWdrhW1TqEI7iuGNPt3fravgTE/tD6zkSqIwM3Z3XZrEUtlA/b
	xx2ZZhqkUKtdiMn//yA/0=
X-Received: by 2002:a5d:4385:0:b0:43d:6655:8ce6 with SMTP id ffacd0b85a97d-43d66558f68mr623766f8f.0.1775800362309;
        Thu, 09 Apr 2026 22:52:42 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63deba9esm5087814f8f.10.2026.04.09.22.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 22:52:41 -0700 (PDT)
Date: Fri, 10 Apr 2026 08:52:38 +0300
From: Dan Carpenter <error27@gmail.com>
To: Suman Ghosh <sumang@marvell.com>
Cc: Ratheesh Kannoth <rkannoth@marvell.com>,
	Suman Ghosh <sumang@marvell.com>, netdev@vger.kernel.org
Subject: [bug report] octeontx2-af: npc: cn20k: Use common APIs
Message-ID: <adiQJvuKlEhq2ILx@stanley.mountain>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277253-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 4E2D43D2779
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Suman Ghosh,

Commit 6d1e70282f76 ("octeontx2-af: npc: cn20k: Use common APIs")
from Feb 24, 2026 (linux-next), leads to the following Smatch static
checker warning:

	drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c:1065 npc_cn20k_config_mcam_entry()
	error: uninitialized symbol 'kw_type'.

drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
    1045 void npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
    1046                                  u8 intf, struct cn20k_mcam_entry *entry,
    1047                                  bool enable, u8 hw_prio, u8 req_kw_type)
    1048 {
    1049         struct npc_mcam *mcam = &rvu->hw->mcam;
    1050         int mcam_idx = index % mcam->banksize;
    1051         int bank = index / mcam->banksize;
    1052         int kw = 0;
    1053         u8 kw_type;
    1054 
    1055         /* Disable before mcam entry update */
    1056         npc_cn20k_enable_mcam_entry(rvu, blkaddr, index, false);
    1057 
    1058         npc_mcam_idx_2_key_type(rvu, index, &kw_type);

No error checking?

    1059         /* CAM1 takes the comparison value and
    1060          * CAM0 specifies match for a bit in key being '0' or '1' or 'dontcare'.
    1061          * CAM1<n> = 0 & CAM0<n> = 1 => match if key<n> = 0
    1062          * CAM1<n> = 1 & CAM0<n> = 0 => match if key<n> = 1
    1063          * CAM1<n> = 0 & CAM0<n> = 0 => always match i.e dontcare.
    1064          */
--> 1065         if (kw_type == NPC_MCAM_KEY_X2) {
                     ^^^^^^^
Uninitialized

    1066                 /* Clear mcam entry to avoid writes being suppressed by NPC */
    1067                 npc_cn20k_clear_mcam_entry(rvu, blkaddr, bank, mcam_idx);
    1068                 npc_cn20k_config_kw_x2(rvu, mcam, blkaddr,

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter

