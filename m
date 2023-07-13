Return-Path: <netdev+bounces-17515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A114751DAA
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 11:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 749E01C21106
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 09:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46983100DE;
	Thu, 13 Jul 2023 09:49:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1FA100C7
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:49:01 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D392126
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:48:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7F2AE1F385;
	Thu, 13 Jul 2023 09:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1689241738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j20Ygka2bvL/7ZoZfn4Cq0kxCBYxWfaUGWpBpPbqXmM=;
	b=q6lVBZ9S98kr4n7JLThEdEhwF/hlwDA3x84qTd1RBdhG9rup9B2+t9CAl7Oy3J9ECrtnl2
	cpdE4NOph9VqLtYhNMgF2E0e8wLO+hmljvN3ifg8OoHCJ/2uegUxW7HLa4EHM4Q64r5lu8
	2XS5/M6XBxjE63nm2a2K9zKoY9bdCJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1689241738;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j20Ygka2bvL/7ZoZfn4Cq0kxCBYxWfaUGWpBpPbqXmM=;
	b=1ZRFGKHK0qxCeJJ8qvOO4w+N6fjRAJ3rpmmugPQS6oGpeb8RvaWAKQdKTBGq7AzImjWczr
	5GIWJgvYBgdbuYAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A21D133D6;
	Thu, 13 Jul 2023 09:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id xoJpGIrIr2SkVwAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 13 Jul 2023 09:48:58 +0000
Message-ID: <1496b59a-10b1-bb49-2d04-5552e002c960@suse.de>
Date: Thu, 13 Jul 2023 11:48:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: nvme-tls and TCP window full
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jakub Kicinski <kuba@kernel.org>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
References: <f10a9e4a-b545-429d-803e-c1d63a084afe@suse.de>
 <49422387-5ea3-af84-3f94-076c94748fff@grimberg.me>
 <ed5b22c6-d862-8706-fc2e-5306ed1eaad2@grimberg.me>
 <a50ee71b-8ee9-7636-917d-694eb2a482b4@suse.de>
 <6a9e0fbf-ca1a-aadd-e79a-c70ecd14bc28@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <6a9e0fbf-ca1a-aadd-e79a-c70ecd14bc28@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/11/23 14:05, Sagi Grimberg wrote:
> 
>>> Hey Hannes,
>>>
>>> Any progress on this one?
>>>
>> Oh well; slow going.
[ .. ]
>> Maybe the server doesn't retire skbs (or not all of them), causing the 
>> TCP window to shrink.
>> That, of course, is wild guessing, as I have no idea if and how calls 
>> to 'consume_skb' reflect back to the TCP window size.
> 
> skbs are unrelated to the TCP window. They relate to the socket send
> buffer. skbs left dangling would cause server side to run out of memory,
> not for the TCP window to close. The two are completely unrelated.

Ouch.
Wasn't me, in the end:

diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index f37f4a0fcd3c..ca1e0e198ceb 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -369,7 +369,6 @@ static int tls_strp_copyin(read_descriptor_t *desc, 
struct sk_buff *in_skb,

  static int tls_strp_read_copyin(struct tls_strparser *strp)
  {
-       struct socket *sock = strp->sk->sk_socket;
         read_descriptor_t desc;

         desc.arg.data = strp;
@@ -377,7 +376,7 @@ static int tls_strp_read_copyin(struct tls_strparser 
*strp)
         desc.count = 1; /* give more than one skb per call */

         /* sk should be locked here, so okay to do read_sock */
-       sock->ops->read_sock(strp->sk, &desc, tls_strp_copyin);
+       tcp_read_sock(strp->sk, &desc, tls_strp_copyin);

         return desc.error;
  }

Otherwise we'd enter a recursion calling ->read_sock(), which will 
redirect to tls_sw_read_sock(), calling tls_strp_check_rcv(), calling 
->read_sock() ...
It got covered up with the tls_rx_reader_lock() Jakub put in, so I 
really only noticed it when instrumenting that one.

And my reading seems that the current in-kernel TLS implementation 
assumes TCP as the underlying transport anyway, so no harm done.
Jakub?

Cheers,

Hannes


