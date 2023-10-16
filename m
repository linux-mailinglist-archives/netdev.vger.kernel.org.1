Return-Path: <netdev+bounces-41531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B187CB343
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 21:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934271C209DC
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 19:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F6634190;
	Mon, 16 Oct 2023 19:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rjmcmahon.com header.i=@rjmcmahon.com header.b="QqbIQkOL"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795C2328BB
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 19:20:13 +0000 (UTC)
X-Greylist: delayed 514 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 Oct 2023 12:20:11 PDT
Received: from bobcat.rjmcmahon.com (bobcat.rjmcmahon.com [45.33.58.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6F183
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 12:20:11 -0700 (PDT)
Received: from mail.rjmcmahon.com (bobcat.rjmcmahon.com [45.33.58.123])
	by bobcat.rjmcmahon.com (Postfix) with ESMTPA id 975721B26F
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 12:11:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 bobcat.rjmcmahon.com 975721B26F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjmcmahon.com;
	s=bobcat; t=1697483497;
	bh=yIgseQ3rBeOZH+xW5LPOx9lCNpKasIFxCIS9YHGab34=;
	h=Date:From:To:Subject:From;
	b=QqbIQkOLrVSHqkkdmjaJccsH40reVt4gmADBj/7emYy2XhhrRz4VtVzdUWB1hRndp
	 RV+gLIMbS0da1iajGpbAcntuChj8McwZbhmRI5GgPOb+G4ckM4QbzmJjBLta7/hvlW
	 BkDj+O7HA1v9GFan1hyOgewfkkuyXEIJdLNL8d9I=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Oct 2023 12:11:37 -0700
From: rjmcmahon <rjmcmahon@rjmcmahon.com>
To: netdev@vger.kernel.org
Subject: Suggest use -e or --enhanced with iperf 2
Message-ID: <f8e887133547cca97d583e78c79f2ee8@rjmcmahon.com>
X-Sender: rjmcmahon@rjmcmahon.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi All,

I suggest the use of enhanced reports w/iperf 2, for those using iperf 2 
version that's actively maintained (not 2.0.5.) This will provide a bit 
more information to the user including CWND & RTT samples.

If the clocks are synced, then also use the --trip-times option on the 
client which will enable latency related stats. There are also 
histograms.

Man page is here: https://iperf2.sourceforge.io/iperf-manpage.html

Finally, there is some python code in the flows directory - though it 
may be a bit brittle.

Source code is here: 
https://sourceforge.net/p/iperf2/code/ci/master/tree/

Bob

