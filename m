Return-Path: <netdev+bounces-280455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DeoNszo6Gl4RgIAu9opvQ
	(envelope-from <netdev+bounces-280455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 17:27:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 166BD447E20
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 17:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2EBE3012C60
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 15:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FE717BB21;
	Wed, 22 Apr 2026 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBnCIUJ5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0058133ADAD
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871382; cv=none; b=UKh5xPoVLlXEaqfrC1BWagyXXZiSmKQbJ6ETV1ul/TrGrLEuB8LruRJCh8zeqw8MBCX/DZxhzlWrTLWzY5DO8zaVVNghpA+O1adVb3atEw//JfjcWBpmsWSXrn1NndDebhaDNjgdSPRdmAsewPsHEIHFEq6sQxhqmHRw4nUfHxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871382; c=relaxed/simple;
	bh=WaAzBz93zy4+rMZv39m6v0KHxfqV3r/1x2qqkZktacQ=;
	h=From:Date:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bekwiI3hrn3jrlI+YccL5nts3HeYNg1lCvZCZlXkFp3oOj23N3tqvlQXIm2gkz7wFenzcwHC8M+VylReI70uX6MoSag082d/BqfMKkzWOJiNhmhXPn7cH5UhZm+o6z+/OgV2svNrPNZRuKz5VTFSWZDRK/qm8jWk2vsWtDaw+8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBnCIUJ5; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43eb05b1875so3328131f8f.3
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 08:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776871377; x=1777476177; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:to
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eQIno5B+jCCWPl3fct9QNDDgC0X0xxcIwgPx80lrh18=;
        b=ZBnCIUJ5uirrt+BhiW5jyILDlLsslZJ2GVAF2soVkcqKFcbatRJ/fPH5Po1QINinzp
         RbdCja/wyQvRE8KDB7vNj44PN2aGwnv85viaFrai0/xguR9cpyDKZ3jlC9mIons4ISgs
         UcCwPKap+MlBO1QBOJRt4hkI4VjephvvAq/5Uet9q5WctC7mw6RyCqMCJKRwSJQsA5i7
         COcV7JgRvAJP8sRo1nynoLIrEhDj9JCJwWkO0QlICnOYqs1ncCfMgzo6W1638AR4YFUf
         UFETuPndyWQgbDxlKwT8pUQUFkl9Gar/m9cY4zoGOjOvgIyLDJO3CJSoPes+ryucFHg6
         IHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776871377; x=1777476177;
        h=content-disposition:mime-version:reply-to:message-id:subject:to
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQIno5B+jCCWPl3fct9QNDDgC0X0xxcIwgPx80lrh18=;
        b=rC9Sz3jqZJXASmYKx3221tHtuDbJFyFc3nVD/F2M0ZPjLgjrd4pc0Ua/UTBEq8RdIJ
         Fc4xnGS+echt5SGUgbwvlOYaVojDEbQ0+7qnEiVxxiJO03ZpAtVmkF6M2N9Hz/ENtu1P
         tF4LUMeWa1shnG72xRYOYAUuR3jfJyyiH1iKpmYtW18oDsNu7TYNMb9ujckYKCqH4HP1
         yQRrx694Ef9+C43au2uhg6qxHT00MFv62ijpQvINhl4Phf9VtfviVBeIGvrKaeiBcmvf
         eQAzMBwIXH3PPllLFxZGGq4x4SBCatJSsnZ5G38QuwNM0v6iUf/6NxCZr+7NkFajR/co
         wYBA==
X-Gm-Message-State: AOJu0YwAtXTKgDJ4RmH4yjmF76fkEJfnPq5mwuzFbesaA6D/F+PUEFyU
	/a1Itcajs5l1h3dGG7YuA2bCof3GtYKCYhvsqw5422GfOXCMyjNMlxjHDQugkw==
X-Gm-Gg: AeBDievHl+OvJb8+ORIP4WYPU1aXNX6x11FLgsjAvvwwLIZdZYvDZjBc0y8J375wATb
	nlzKBdadMy+SU4g2H5nYtV9dGSYBpoqU8CzPStwBWWUV1WJbIhIW4P596EyrAl1WTqh0J0ZJAnH
	R00V7sJDBqfftn3dcMUwBnvN6uGSrk/zmccXw8c3UVZbpvGu/010w4pFyNG6xuQr47Z8eoR4U3c
	TZWHlb0nBUIr2OwqDc/vVThdcSPpO3dvO85llhdSBJ5hQpM7QXLsMx7ZTeYQJYOWfGoh3vZam4v
	JvncMhbsajklSKIgzaQ4a09SEDcmaClFhPWyPoBar/GPyDCaNtFiuMIWjHhAWSyhQsI4iDx/lSU
	pELRHbC9hcPFBDdW0s60dniLEPmwyFN5416WHp96/jgENuqt34T2vjKjsQAQgUiucLDti+pCEPk
	gQSAaR/stDeGwEhfVygkKICSujtLBQPcu0qiYVzEgI/ntSwR6Eu7TtMPb1e5wOSIwezVgpVA==
X-Received: by 2002:a5d:584c:0:b0:43d:7403:4b57 with SMTP id ffacd0b85a97d-43fe3db3ca7mr35551311f8f.10.1776871377281;
        Wed, 22 Apr 2026 08:22:57 -0700 (PDT)
Received: from watcher (102-182-140-48.ip.afrihost.capetown. [102.182.140.48])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4daf2sm45110635f8f.33.2026.04.22.08.22.56
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 08:22:56 -0700 (PDT)
From: Bruce Merry <bmerry.robot@gmail.com>
X-Google-Original-From: Bruce Merry <bmerry@gmail.com>
Received: by watcher (Postfix, from userid 1000)
	id B79622C05BA; Wed, 22 Apr 2026 17:22:53 +0200 (SAST)
Date: Wed, 22 Apr 2026 17:22:53 +0200
To: netdev@vger.kernel.org
Subject: Help with PCIe THP on ConnectX-7
Message-ID: <aejnzWR_szvAOxkK@brucemerry.org.za>
Reply-To: bmerry@gmail.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-0.16 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-280455-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[bmerry@gmail.com];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_EQ_FROM_DOM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmerryrobot@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,brucemerry.org.za:mid,brucemerry.org.za:url]
X-Rspamd-Queue-Id: 166BD447E20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello

I'm hoping someone from NVIDIA Networking can help with this; I wasn't
sure of the best way to get in contact with the engineers working on
mlx5 kernel code so thought I'd try here. I'm trying to write some
(userspace) code using ibv_reg_mr_ex to register a memory region using
TLP Processing Hints (THP) to improve performance on an Epyc Turin
(Zen 5) system. However, in the kernel mlx5_st_create is bailing out
because of this check:

       if (!MLX5_CAP_GEN(dev, mkey_pcie_tph))
                return NULL;

As far as I can tell, that is checking a capability bit returned by
the firmware.

Before I spend a lot more time debugging, can you tell me whether
ConnectX-7 supports this feature at all (I'm on the latest 28.48.1000
firmware)? I see it mentioned in release notes for ConnectX-8
firmware, but not in ConnectX-7 release notes.

If ConnectX-7 does support it, do you have any tips on what might
cause that capability bit to be false and how to determine what the
cause is? For example, could that happen if the motherboard BIOS
doesn't support TPH?

Thanks
Bruce
-- 
Dr Bruce Merry
bmerry <@> gmail <.> com
http://www.brucemerry.org.za/
http://blog.brucemerry.org.za/


