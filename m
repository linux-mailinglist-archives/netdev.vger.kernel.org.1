Return-Path: <netdev+bounces-38031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 296F57B8A3A
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 20:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D933B281771
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 18:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B0C1BDE9;
	Wed,  4 Oct 2023 18:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="EIoPFwXt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E11F21360
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 18:33:26 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BB0C1;
	Wed,  4 Oct 2023 11:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=toVucifvQkY3aRDPKTi6NGRl7yNtpQ93dM9FsQF5b5k=;
	t=1696444404; x=1697654004; b=EIoPFwXt5oTwUQwrqKKOzqOiHzA73brakbDS6satqXew/4T
	gMis8cWEk4Xhe7BRv6yFeQejyED5KdWpJZ1PVjujFKA4yrsRRtKjxiqhskD+t5VnY4i/T6C6DfpPn
	mzW5/aPG5a1hyhzTeo5bjbVxZwV7tLZitnRDjwGVTssAl609apei18tMkWDdEYG06kGb2eFKNRS8B
	Uzgi2SnkJbIVK5MwftkEDb4D8y8qhFGr5ZwW+S9kPNgCZnd/sNtdyV1Xu/pIqIPGzey0Ge4lS8uCn
	krHUYTNCmdKjQJMgr+9anUON0iEs2KOmiG02KY9KwmcabIcxFO6sOFTTydOZ750A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC0)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qo6gS-00000004PQg-1SQ1;
	Wed, 04 Oct 2023 20:33:20 +0200
Message-ID: <58214dab3b0932a7ea2809df25aa31a242c7a72b.camel@sipsolutions.net>
Subject: Re: [PATCH] wext.h: Clean up errors in wext.h
From: Johannes Berg <johannes@sipsolutions.net>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 04 Oct 2023 20:33:19 +0200
In-Reply-To: <7c5744ca.8aa.18ad9c22e75.Coremail.wangkailong@jari.cn>
References: <7c5744ca.8aa.18ad9c22e75.Coremail.wangkailong@jari.cn>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For the record, the sender address bounces.

johannes

