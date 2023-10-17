Return-Path: <netdev+bounces-41620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2291B7CB74E
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 02:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C75528142D
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 00:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400A619C;
	Tue, 17 Oct 2023 00:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50EB19A
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 00:20:24 +0000 (UTC)
X-Greylist: delayed 346 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 Oct 2023 17:20:23 PDT
Received: from mx.ewheeler.net (mx.ewheeler.net [173.205.220.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A62092
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 17:20:23 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 37FF049
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 17:14:37 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id rctnwX2BoVav for <netdev@vger.kernel.org>;
	Mon, 16 Oct 2023 17:14:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 67D9740
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 17:14:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 67D9740
Date: Mon, 16 Oct 2023 17:14:36 -0700 (PDT)
From: Eric Wheeler <netdev@lists.ewheeler.net>
To: netdev@vger.kernel.org
Message-ID: <96edb9d-4bb0-e4da-85e-184ccc2b8574@ewheeler.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_50,MISSING_SUBJECT,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,TVD_SPACE_RATIO
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

subscribe netdev@vger.kernel.org

