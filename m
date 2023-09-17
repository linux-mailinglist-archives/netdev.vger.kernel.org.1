Return-Path: <netdev+bounces-34341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5BD7A357D
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 14:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9CC281414
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 12:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A32B3C35;
	Sun, 17 Sep 2023 12:09:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69EE2594
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 12:09:22 +0000 (UTC)
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 17 Sep 2023 05:09:19 PDT
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF8E12B
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 05:09:18 -0700 (PDT)
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <gl-netdev-2@m.gmane-mx.org>)
	id 1qhqVZ-0006L4-FK
	for netdev@vger.kernel.org; Sun, 17 Sep 2023 14:04:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: netdev@vger.kernel.org
From: Holger =?iso-8859-1?q?Hoffst=E4tte?= <holger@applied-asynchrony.com>
Subject: Re: Urgent Bug Report Kernel crash 6.5.2
Date: Sun, 17 Sep 2023 12:04:08 -0000 (UTC)
Message-ID: <pan$7665b$7d10e741$bd96a442$c2861d9e@applied-asynchrony.com>
References: <64CCB695-BA43-48F5-912A-AFD5B9C103A7@gmail.com>
	<51294220-A244-46A9-A5B8-34819CE30CF4@gmail.com>
	<67303CFE-1938-4510-B9AE-5038BF98ABB7@gmail.com>
	<8a62f57a9454b0592ab82248fca5a21fc963995b.camel@redhat.com>
	<CALidq=UR=3rOHZczCnb1bEhbt9So60UZ5y60Cdh4aP41FkB5Tw@mail.gmail.com>
	<43ED0333-18AB-4C38-A615-7755E5BE9C3E@gmail.com>
	<5A853CC5-F15C-4F30-B845-D9E5B43EC039@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
User-Agent: Pan/0.151 (Butcha; a6f63273)
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_40,
	HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, 17 Sep 2023 14:55:25 +0300, Martin Zaharinov wrote:

> Hi Eric
> is it possible bug to come from this patch : https://patchwork.kernel.org/project/netdevbpf/cover/20230911170531.828100-1-edumazet@google.com/ 

No, because

1) those patches are not in any released kernel
2) they work fine

Holger


