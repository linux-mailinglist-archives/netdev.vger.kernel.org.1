Return-Path: <netdev+bounces-46001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DA97E0CAD
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 01:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154811C209DD
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 00:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C50A196;
	Sat,  4 Nov 2023 00:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="YgP7HlGI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A193188
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 00:15:31 +0000 (UTC)
X-Greylist: delayed 1157 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Nov 2023 17:15:29 PDT
Received: from smtp2.cs.Stanford.EDU (smtp2.cs.stanford.edu [171.64.64.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F618194
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 17:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Type:Cc:To:Subject:Message-ID:Date:
	From:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xMizlyfcVq7CIsFI1WfgDky57L7HB8DkLawDXVg+1hY=; t=1699056929; x=1699920929; 
	b=YgP7HlGIKNNwAkmbxSlJqHeqoi0+Uqvd9v61w0yMWQbaNXCP4HK0Yo1DcffLKaraumESRGdj1Zq
	KXiuiqd4Z06UrtDH4h43Ha5eDheiIpVSgpbmfaKyUSzrBNYQtDmjlZ4Hp+BjyuqJXIrlzhs9Tjgdq
	vOt2ReFOdYF4HfUG/2xc5fVonIfRhLMJ7oMQblr3ERfyFskHOBSdLflX7mgqsYh9Ftj4ya4VPiWzx
	mqH8ogokjnjubXzdwJT8icrSuSVlKzcRS146fR8qS7yDp1/1WPKCIAavq3jCEEfLAyBneoVfQrKMT
	oJS0PFE0ZlCqKKL5IJXns2ITo40P6Td6k9lw==;
Received: from mail-oa1-f45.google.com ([209.85.160.45]:52506)
	by smtp2.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1qz41L-0004ar-6p
	for netdev@vger.kernel.org; Fri, 03 Nov 2023 16:56:12 -0700
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1f04c5ed8d7so1365159fac.1
        for <netdev@vger.kernel.org>; Fri, 03 Nov 2023 16:56:11 -0700 (PDT)
X-Gm-Message-State: AOJu0YzLruf3/JgPciqquzTo43A7/GXtczXriRZILZmUw84uabKgeHDb
	AlW/zIxpU0QxXRKSUIsedlE4++bhdc1R0RSSuoY=
X-Google-Smtp-Source: AGHT+IEU3X561zLFo5DjG4USWHu66NipLIfg46Nwd0zdxpRrbbDwDpuSxl4O5Qy0upQ8Wp0Lfvcn4lIM2YhiN+qvsdA=
X-Received: by 2002:a05:6871:2303:b0:1e9:a770:61eb with SMTP id
 sf3-20020a056871230300b001e9a77061ebmr28888635oab.29.1699055771197; Fri, 03
 Nov 2023 16:56:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Fri, 3 Nov 2023 16:55:35 -0700
X-Gmail-Original-Message-ID: <CAGXJAmy-0_GV7pR5_3NNArWZumunRijHeSJnY=VEf8RjmegZZw@mail.gmail.com>
Message-ID: <CAGXJAmy-0_GV7pR5_3NNArWZumunRijHeSJnY=VEf8RjmegZZw@mail.gmail.com>
Subject: Bypass qdiscs?
To: netdev@vger.kernel.org
Cc: John Ousterhout <ouster@cs.stanford.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Score: 1.7
X-Scan-Signature: 946122a1693bfdbb49d371411bb557d1

Is there a way to mark an skb (or its socket) before invoking
ip_queue_xmit/ip6_xmit so that the packet will bypass the qdiscs and
be transmitted immediately? Is doing such a thing considered bad
practice?

(Homa has its own packet scheduling mechanism so the qdiscs are just
getting in the way and adding delays)

-John-

