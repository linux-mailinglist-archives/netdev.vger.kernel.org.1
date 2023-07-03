Return-Path: <netdev+bounces-15130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B694745CF3
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 15:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ADB31C20996
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 13:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D5AF9C6;
	Mon,  3 Jul 2023 13:15:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C14DF4C
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 13:15:40 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215D6DD
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 06:15:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B28C31FE51;
	Mon,  3 Jul 2023 13:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1688390137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=739dHYzg5oExmvbSo2BuS/tkAu90YM6Fl3+TFCGLX6A=;
	b=cuQeM096io5t/AxOPgR6RHQZYZHAm2485B+SxdX9HvZoSGkQhZ7FTKsAA5YyMtvYfiTK8N
	ouIDnihpA2IMiz9ox7KmrrlPftO4soWPJl70WETmN5W7YsYmiMgp1SnQZyvjMGGH0Kw0uo
	xS5t1jeXLeibvMgvvmU3yoPbIypj34U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688390137;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=739dHYzg5oExmvbSo2BuS/tkAu90YM6Fl3+TFCGLX6A=;
	b=XiSeRMlV4U2sb/8AK7UKj9ehbVZZxebCEFqW2LaWhnCCy9tyCWkb74SrGKyH3YtvRIiU1B
	vpj3uNAHXz+UUXCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 98DF1138FC;
	Mon,  3 Jul 2023 13:15:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id b8vzJPnJomS4EgAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 03 Jul 2023 13:15:37 +0000
Message-ID: <b33737ab-d923-173c-efcc-9e5c920e6dbf@suse.de>
Date: Mon, 3 Jul 2023 15:15:37 +0200
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
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <12a716d5-d493-bea9-8c16-961291451e3d@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/3/23 14:33, Sagi Grimberg wrote:
> 
>> Hannes Reinecke <hare@suse.de> wrote:
>>
>>>> 'discover' and 'connect' works, but when I'm trying to transfer data
>>>> (eg by doing a 'mkfs.xfs') the whole thing crashes horribly in
>>>> sock_sendmsg() as it's trying to access invalid pages :-(
>>
>> Can you be more specific about the crash?
> 
> Hannes,
> 
> See:
> [PATCH net] nvme-tcp: Fix comma-related oops

Ah, right. That solves _that_ issue.

But now I'm deadlocking on the tls_rx_reader_lock() (patched as to your 
suggestion). Investigating.

But it brought up yet another can of worms: what _exactly_ is the return 
value of ->read_sock()?

There are currently two conflicting use-cases:
-> Ignore the return value, and assume errors etc are signalled
    via 'desc.error'.
    net/strparser/strparser.c
    drivers/infiniband/sw/siw
    drivers/scsi/iscsi_tcp.c
-> use the return value of ->read_sock(), ignoring 'desc.error':
    drivers/nvme/host/tcp.c
    net/ipv4/tcp.c
So which one is it?
Needless to say, implementations following the second style do not
set 'desc.error', causing any errors there to be ignored for callers
from the first style...
Jakub?

Cheers,

Hannes


