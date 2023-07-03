Return-Path: <netdev+bounces-15121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC20745C50
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 14:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8221C209B7
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 12:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1295F2115;
	Mon,  3 Jul 2023 12:36:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008A8DF4C
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 12:35:59 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AAEBB
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 05:35:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 002F21F8D4;
	Mon,  3 Jul 2023 12:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1688387757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b3YgvufvKI5tg/IzlN1ntqeK1qezoU+hG26nb9haDpU=;
	b=x1YJjzl84jbN9pIi5mr6aOafCJo6BEYD8FA+ZRJDjOPh97zurMcR8X2WWTdhUEN5sJ48Kx
	QiXERGvofMZ7IG5yNS9rEovwqIceSyvH5rE0T3d63kyFJexrWjTvh1mzOo/3VnzMaVKNwI
	9MK+SYpUzmDjPKT89BLz7GOXT+msVkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688387757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b3YgvufvKI5tg/IzlN1ntqeK1qezoU+hG26nb9haDpU=;
	b=Y9O+x9OIgZWaDkiyEvm0AtIOWpbKP2RBFGmDzSfCiopM+7RqW5lNpOSQBLEXxZP+NERrGr
	NEarQ1qjytqk1kDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE752138FC;
	Mon,  3 Jul 2023 12:35:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Ip68MazAomRhewAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 03 Jul 2023 12:35:56 +0000
Message-ID: <6859f3b7-90fa-7071-857e-d9354165a445@suse.de>
Date: Mon, 3 Jul 2023 14:35:52 +0200
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
To: David Howells <dhowells@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <03dd8a0d-84b9-c925-9547-99f708e88997@suse.de>
 <20230703090444.38734-1-hare@suse.de>
 <8fbfa483-caed-870f-68ed-40855feb601f@grimberg.me>
 <e1165086-fd99-ff43-4bca-d39dd1e46cf1@suse.de>
 <bf72459d-c2e0-27d2-ad96-89a010f64408@suse.de>
 <873545.1688387166@warthog.procyon.org.uk>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <873545.1688387166@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/3/23 14:26, David Howells wrote:
> Hannes Reinecke <hare@suse.de> wrote:
> 
>>> 'discover' and 'connect' works, but when I'm trying to transfer data
>>> (eg by doing a 'mkfs.xfs') the whole thing crashes horribly in
>>> sock_sendmsg() as it's trying to access invalid pages :-(
> 
> Can you be more specific about the crash?
> 
[ 1804.190109] nvme nvme0: new ctrl: NQN "nqn.test", addr 127.0.0.1:4420
[ 1814.346751] BUG: unable to handle page fault for address: 
ffffffffc4e166cc
[ 1814.347980] #PF: supervisor read access in kernel mode
[ 1814.348864] #PF: error_code(0x0000) - not-present page
[ 1814.349727] PGD 2b239067 P4D 2b239067 PUD 2b23b067 PMD 0
[ 1814.350630] Oops: 0000 [#1] PREEMPT SMP NOPTI
[ 1814.351369] CPU: 0 PID: 2309 Comm: mkfs.xfs Kdump: loaded Tainted: G 
           E      6.4.0-54-default+ #296
[ 1814.353021] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
0.0.0 02/06/2015
[ 1814.354298] RIP: 0010:skb_splice_from_iter+0xda/0x310
[ 1814.355171] Code: 0f 8e 2f 02 00 00 4c 8d 6c 24 30 48 8b 54 24 28 4c 
89 f8 4d 89 f7 4d 89 ee 49 89 c5 49 8b 1e bd 00
10 00 00 48 29 d5 4c 39 fd <48> 8b 43 08 49 0f 47 ef a8 01 0f 85 c9 01 
00 00 66 90 48 89 d8 48
[ 1814.358314] RSP: 0018:ffffa90f00db7778 EFLAGS: 00010283
[ 1814.359202] RAX: ffff8941ad156600 RBX: ffffffffc4e166c4 RCX: 
0000000000000000
[ 1814.360426] RDX: 0000000000000fff RSI: 0000000000000000 RDI: 
0000000000000000
[ 1814.361613] RBP: 0000000000000001 R08: ffffa90f00db7958 R09: 
00000000ac6df68e
[ 1814.362797] R10: 0000000000020000 R11: ffffffffac9873c0 R12: 
0000000000000000
[ 1814.363998] R13: ffff8941ad156600 R14: ffffa90f00db77a8 R15: 
0000000000001000
[ 1814.365175] FS:  00007f5f0ea63780(0000) GS:ffff8941fb400000(0000) 
knlGS:0000000000000000
[ 1814.366493] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1814.367456] CR2: ffffffffc4e166cc CR3: 0000000005e68000 CR4: 
0000000000350ef0
[ 1814.368671] Call Trace:
[ 1814.369092]  <TASK>
[ 1814.369463]  ? __die_body+0x1a/0x60
[ 1814.370060]  ? page_fault_oops+0x151/0x470
[ 1814.370746]  ? search_bpf_extables+0x65/0x70
[ 1814.371471]  ? fixup_exception+0x22/0x310
[ 1814.372162]  ? exc_page_fault+0xb1/0x150
[ 1814.372822]  ? asm_exc_page_fault+0x22/0x30
[ 1814.373521]  ? kmem_cache_alloc_node+0x1c0/0x320
[ 1814.374294]  ? skb_splice_from_iter+0xda/0x310
[ 1814.375036]  ? skb_splice_from_iter+0xa9/0x310
[ 1814.375777]  tcp_sendmsg_locked+0x763/0xce0
[ 1814.376488]  ? tcp_sendmsg_locked+0x936/0xce0
[ 1814.377225]  tcp_sendmsg+0x27/0x40
[ 1814.377797]  sock_sendmsg+0x8b/0xa0
[ 1814.378386]  nvme_tcp_try_send_data+0x131/0x400 [nvme_tcp]
[ 1814.379297]  ? nvme_tcp_try_send_cmd_pdu+0x164/0x290 [nvme_tcp]
[ 1814.380302]  ? __kernel_text_address+0xe/0x40
[ 1814.381037]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[ 1814.381909]  ? arch_stack_walk+0xa1/0xf0
[ 1814.382565]  nvme_tcp_try_send+0x197/0x2c0 [nvme_tcp]
[ 1814.383407]  ? __rq_qos_issue+0x24/0x40
[ 1814.384069]  nvme_tcp_queue_rq+0x38b/0x3c0 [nvme_tcp]
[ 1814.384907]  __blk_mq_issue_directly+0x3e/0xe0
[ 1814.385648]  blk_mq_try_issue_directly+0x6c/0xa0
[ 1814.386411]  blk_mq_submit_bio+0x52b/0x650
[ 1814.387095]  __submit_bio+0xd8/0x150
[ 1814.387697]  submit_bio_noacct_nocheck+0x151/0x360
[ 1814.388503]  ? submit_bio_wait+0x54/0xc0
[ 1814.389157]  submit_bio_wait+0x54/0xc0
[ 1814.389780]  __blkdev_direct_IO_simple+0x124/0x280

My suspicion is here:

         while (true) {
                 struct bio_vec bvec;
                 struct msghdr msg = {
                         .msg_flags = MSG_DONTWAIT | MSG_SPLICE_PAGES,
                 };
                 struct page *page = nvme_tcp_req_cur_page(req);
                 size_t offset = nvme_tcp_req_cur_offset(req);
                 size_t len = nvme_tcp_req_cur_length(req);
                 bool last = nvme_tcp_pdu_last_send(req, len);
                 int req_data_sent = req->data_sent;
                 int ret;

                 if (!last || queue->data_digest || 
nvme_tcp_queue_more(queue))
                         msg.msg_flags |= MSG_MORE;

                 if (!sendpage_ok(page))
                         msg.msg_flags &= ~MSG_SPLICE_PAGES,

                 bvec_set_page(&bvec, page, len, offset);
                 iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);
                 ret = sock_sendmsg(queue->sock, &msg);

Thing is, 'req' already has an iter (that's what nvme_tcp_req_cur_page() 
extracts from.
Maybe a missing kmap() somewhere?
But the entire thing is borderline pedantic.
'req' already has an iter, so we should be using it directly and not 
create another iter which just replicates the existing one.

Cheers,

Hannes


