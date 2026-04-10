Return-Path: <netdev+bounces-277324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIuZDxfQ2GngiQgAu9opvQ
	(envelope-from <netdev+bounces-277324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 12:25:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E013D5A4B
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 12:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A508E3031800
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 10:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694E03590A9;
	Fri, 10 Apr 2026 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIb8/n3L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5EE3176E4
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775816207; cv=none; b=g8pf6Bkgpiwq8FCR9ZalFoFZnBGC0IuegiHm9/jHVfb82zLN0u4mU4Bq4uRC6vFbtZBvCzS63Eq94c64AVaGxma8PX4N9R/1Wq74FiPSedyxYi6z50Wmex8NXUgBik+lUWpbgbO+LkZmAw6CbcTBKSJWdCTqbG+0DA4OMh6KTwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775816207; c=relaxed/simple;
	bh=bTdNN7WD8kntYv71PIB4Ub29LjSLZkiKY6rDfVA+DbM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ky5HX739FYkLk1OCjJAjo2gINf7UHrOKb1M08s0jaiiPJ8I2bdVicD2XIyVo0v4hqrlxd9l4cGmNc78VqQ5bOSaOpe+IiC/kowy64WifORLWpGXhJtx6UCXoYH5bi3kxz+lMIz5MiUEOFXbFdvY6MEF9V5ddU95MrIgjrQhZ5Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIb8/n3L; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso21487495e9.2
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 03:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775816204; x=1776421004; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=txmLoGCoKgdrToFXN0Js/UfR4KtS11aCDlbGXLQF5Qc=;
        b=WIb8/n3L52z1//XKP+5Mnn+B9Gsnm0zFipqpnM0UPbCDNAlgr16n4rlphuwp/sHFgT
         W+xocDDTNTcaYGei5Gih/qvl7m1NHHZEOk3xbuezdgLNc0TzLd6FsFRRyOqy/O3CRRWE
         haaNfiCSoE2xXTCMHWMNWmDsxLzXaXcc5lbmsNHcU33cyRty9cMyz4guruQDnj0Kq3Lm
         I7BKvJ63wzz1UOxEsdQqNoD3CbVofofjJhuhC0LsQvANw6irwaF2Mu064au2BNJai6z9
         3EK8S6SFg+XE9/RU6Wg3jqJv3L1MS+SozMe089Uyf3beimWlivwEoHCgM/CbIEsVqpQo
         IaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775816204; x=1776421004;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=txmLoGCoKgdrToFXN0Js/UfR4KtS11aCDlbGXLQF5Qc=;
        b=fyDtobPlIzz3qQrXmAjSJ2/95P5YtMbpcspkhCFj6vPuq97Yg7WDbvopzn9N6HogOa
         6k++GOzVOAOjzoYn55wfAUy4u54QSuZlgnlbbiNwP2XfrCzp9qrOE8+hcFzWN+f46ROO
         3TcM2Moed5/VXeUTI8V7W0O0c/ZI8jPgxjojMtXoGibpyCKRzz1tUivp9kSTXc5kzuka
         U+1YaELKGK9BmNEk2UVeTpoU5hmuKgIMZ0ZKkUFWbfJ8sM1WRbLsZkiioGTl22aFhkGu
         BC/QOPKBxU3Qm58ay3qLnLrNE8+V099EyDScdpi4NWkZp3mRgdEbT6wAWUyY1Z3xIe4f
         49zw==
X-Forwarded-Encrypted: i=1; AJvYcCWn7fhNoszn7F9Q8G31PA5uJ5I+LyWHbfcN208sD6/gmw5TwJg36Uj7wsl0RwIVAEELJ5CHrn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvntGos9Ad4jIka4vxUZxlgUkzsnZxl+0Qi0VbYIovH7Kngbeu
	vIdTgkh2A0+2cKHsH0XHG/GNI0SYyASBDormfgtBqqUHJl48blWcpjNq
X-Gm-Gg: AeBDieuTEaPQ0bISAHo39ClaKItqy3t7OlFZFG19H01hX4MpRN7HJDIEyJgbfyuHNPT
	ljgH2On4UqF++4f9jJuDvs/DL+AchdJOQ8N39z6DPpTbEXW4ab90lvU4Ie/Uo34ccWhuPmu7HEW
	JlRTwHfJToHwgkhMVdGS6BKzGF5zsXJehMATFjN7Bjlj1Q0OJSR/1HNZy6uhTCHMZOU39l2QEg7
	JDbd3pw+vsC4xMuKNbODNmHctThUNMDlBfF5F+7nViCL0yfaSMfCwIijbp6qgF53j9RrIwu5V+I
	IFF29t1QGYQzNBesQ1X4K6H93yrGEeyoLIgF81Y6/MogUEIRGODF8DqZ/g0vrEJAB2m5IOp0Po6
	9LZEm4pzctFWgA/iBhhg2+Pz1GZls2E+KQlM1pn0tQ9hxIOF27h7/M+hSdBFmiIZ46kCM1socCD
	O95G7C/n692WeHam/nP2n2pRy9Cj2IxA==
X-Received: by 2002:a05:600d:d:b0:485:4eaf:eb54 with SMTP id 5b1f17b1804b1-488d684b88amr24792675e9.20.1775816204398;
        Fri, 10 Apr 2026 03:16:44 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5396293sm55661675e9.15.2026.04.10.03.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:16:43 -0700 (PDT)
Date: Fri, 10 Apr 2026 13:16:41 +0300
From: Dan Carpenter <error27@gmail.com>
To: Yiqi Sun <sunyiqixm@gmail.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: [bug report] ipv4: icmp: fix null-ptr-deref in icmp_build_probe()
Message-ID: <adjOCdCW1EpPl8lf@stanley.mountain>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277324-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,suse.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,stanley.mountain:mid]
X-Rspamd-Queue-Id: 96E013D5A4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Yiqi Sun,

Commit fde29fd93493 ("ipv4: icmp: fix null-ptr-deref in
icmp_build_probe()") from Apr 2, 2026 (linux-next), leads to the
following Smatch static checker warning:

	net/ipv4/icmp.c:1351 icmp_build_probe()
	warn: 'dev' is not an error pointer

net/ipv4/icmp.c
    1341 #if IS_ENABLED(CONFIG_IPV6)
    1342                 case ICMP_AFI_IP6:
    1343                         if (iio->ident.addr.ctype3_hdr.addrlen != sizeof(struct in6_addr))
    1344                                 goto send_mal_query;
    1345                         dev = ipv6_dev_find(net, &iio->ident.addr.ip_addr.ipv6_addr, dev);
    1346 
    1347                         /*
    1348                          * If IPv6 identifier lookup is unavailable, silently
    1349                          * discard the request instead of misreporting NO_IF.
    1350                          */
--> 1351                         if (IS_ERR(dev))
    1352                                 return false;

It looks like there were two patches that went in around the same
time.  Commit fde29fd93493 ("ipv4: icmp: fix null-ptr-deref in
icmp_build_probe()") updated the checking for
ipv6_stub->ipv6_dev_find() but d98adfbdd5c0 ("ipv4: drop ipv6_stub usage
and use direct function calls") changed it to not return error pointers.

This IS_ERR() check can be removed.

    1353 
    1354                         dev_hold(dev);
    1355                         break;
    1356 #endif
    1357                 default:
    1358                         goto send_mal_query;
    1359                 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter

