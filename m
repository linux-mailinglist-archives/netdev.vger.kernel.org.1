Return-Path: <netdev+bounces-15134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF75745DAD
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 15:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC7C280DCF
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 13:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B19F9DE;
	Mon,  3 Jul 2023 13:46:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27168EAD0
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 13:46:39 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5346BFF
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 06:46:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0ACD021A09;
	Mon,  3 Jul 2023 13:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1688391996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTPPuOy0fLOWkWFxmPGwKo0zoZKMu8As8Gl2gXMrGWY=;
	b=BrkSskJWAHK4FswRrmNtWKWGh10ymV6VZKNQyBh05BhP0cPuQnSaaxQi8nVByrqQ+bZs69
	xma6+HvFDjYQWnv0XQJ7G+lpn5wcb88UMnhUNgNpyjm88bxHrX0u3Odi9+NSTZ920iCpOg
	vSbGjPVArpGHYPHguGopDOuK6T97wdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688391996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTPPuOy0fLOWkWFxmPGwKo0zoZKMu8As8Gl2gXMrGWY=;
	b=kIEYpBKnuCmQZZNlzz8lQvMQuPe9RIARAbsC/joB/lxb7vgS61ULuJjerhz6Iu5VA+i4Oq
	J1vDO32/1Bl2CSBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E7D7513276;
	Mon,  3 Jul 2023 13:46:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id D7EeODvRomRXJgAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 03 Jul 2023 13:46:35 +0000
Message-ID: <656f77b1-caf6-ea3c-6d32-54637f70a629@suse.de>
Date: Mon, 3 Jul 2023 15:46:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCHv6 0/5] net/tls: fixes for NVMe-over-TLS
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, David Howells <dhowells@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <03dd8a0d-84b9-c925-9547-99f708e88997@suse.de>
 <20230703090444.38734-1-hare@suse.de>
 <8fbfa483-caed-870f-68ed-40855feb601f@grimberg.me>
 <e1165086-fd99-ff43-4bca-d39dd1e46cf1@suse.de>
 <bf72459d-c2e0-27d2-ad96-89a010f64408@suse.de>
 <873545.1688387166@warthog.procyon.org.uk>
 <12a716d5-d493-bea9-8c16-961291451e3d@grimberg.me>
 <b33737ab-d923-173c-efcc-9e5c920e6dbf@suse.de>
 <173e27fe-18bb-6194-2af3-1743bc0f8f61@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <173e27fe-18bb-6194-2af3-1743bc0f8f61@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/3/23 15:42, Sagi Grimberg wrote:
> 
>>>> Hannes Reinecke <hare@suse.de> wrote:
>>>>
>>>>>> 'discover' and 'connect' works, but when I'm trying to transfer data
>>>>>> (eg by doing a 'mkfs.xfs') the whole thing crashes horribly in
>>>>>> sock_sendmsg() as it's trying to access invalid pages :-(
>>>>
>>>> Can you be more specific about the crash?
>>>
>>> Hannes,
>>>
>>> See:
>>> [PATCH net] nvme-tcp: Fix comma-related oops
>>
>> Ah, right. That solves _that_ issue.
>>
>> But now I'm deadlocking on the tls_rx_reader_lock() (patched as to 
>> your suggestion). Investigating.
> 
> Are you sure it is a deadlock? or maybe you returned EAGAIN and nvme-tcp
> does not interpret this as a transient status and simply returns from
> io_work?
> 
>> But it brought up yet another can of worms: what _exactly_ is the 
>> return value of ->read_sock()?
>>
>> There are currently two conflicting use-cases:
>> -> Ignore the return value, and assume errors etc are signalled
>>     via 'desc.error'.
>>     net/strparser/strparser.c
>>     drivers/infiniband/sw/siw
>>     drivers/scsi/iscsi_tcp.c
>> -> use the return value of ->read_sock(), ignoring 'desc.error':
>>     drivers/nvme/host/tcp.c
>>     net/ipv4/tcp.c
>> So which one is it?
>> Needless to say, implementations following the second style do not
>> set 'desc.error', causing any errors there to be ignored for callers
>> from the first style...
> 
> I don't think ignoring the return value of read_sock makes sense because
> it can fail outside of the recv_actor failures.
> 
Oh, but it's not read_actor which is expected to set desc.error.
Have a look at 'strp_read_sock()':

         /* sk should be locked here, so okay to do read_sock */
         sock->ops->read_sock(strp->sk, &desc, strp_recv);

         desc.error = strp->cb.read_sock_done(strp, desc.error);

it's the ->read_sock() callback which is expected to set desc.error.

> But to be on the safe side, perhaps you can both return an error and set
> desc.error?
> 
But why? We can easily make ->read_sock() a void function, then it's 
obvious that you can't check the return value.

Cheers,

Hannes


