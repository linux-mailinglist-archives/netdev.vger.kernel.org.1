Return-Path: <netdev+bounces-288545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GzvDg3GB2pEHwMAu9opvQ
	(envelope-from <netdev+bounces-288545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:19:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8679C559BC6
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED7A63036383
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A456238C36;
	Sat, 16 May 2026 01:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdN9IIDp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB30F225416;
	Sat, 16 May 2026 01:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778894235; cv=none; b=GS8yZnMrisNk1oeqfYO+92sgRW4Heqy9w0edMcWRQv7Nq9wmJ9E9en0nslq/mzrmJUJ/1jNHq6CW0m0Crm/9B7TsUeQc2SI0pYL8sbrpiifPOuPVpZngI3JZfCT+l8bVvE2nuRxsyR9tqF8QzycjhvNLJhuiXP+pf4YOR7fW/Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778894235; c=relaxed/simple;
	bh=A+wEi9vHjjbDu6L6qt4CkJFljTfPFJ8Jtv5jIw3sdIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8jy9Z7lh6Po4JThdQm1cklScLbECRXvOTjvTEmvtXrxae5kT9JLEd2Sz/FVUPlwwMvH55Nhk2sXWKR3DjDc7rd2xNHXZhsHHoEH5H2Eq8a8LgcQp3Vwz2cIctOlZxbfMCrR4I+UkqBwzWxLdOiMBd3j2twXmcz3LB4MhgUvU3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdN9IIDp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCB4C2BCB0;
	Sat, 16 May 2026 01:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778894235;
	bh=A+wEi9vHjjbDu6L6qt4CkJFljTfPFJ8Jtv5jIw3sdIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WdN9IIDpEZC0cjM7XgYPqrRGXpaTsVe27Jd4f0w8AOfVIhqFISe/71QYw3L3MkC8h
	 9ykKfVtRxWGZg8CHzwgcQEb9dTBvr9o3ithVJLk/BqI0/9nkFHNeG47OmupGWC3Yvb
	 tUfU+jv/qJ+nCJYi9T1abvId16FXVej1lUj7o0liu5Aloj22q8bjKoMR+taxZjgz64
	 kdqOFWGgGdk6kVfLryYi1kh+qazJO4ydA5mrS8y4UrVu1gSNzVEJhqV/b51jYh4CuQ
	 nRLY8Y2gAstZQiBgkN6/oEWhqDUGDN+m46nvHp1bxwaby++H64YKtyGUaC5EJexNYm
	 a1rP3umfCvQfQ==
From: Jakub Kicinski <kuba@kernel.org>
To: illusion.wang@nebula-matrix.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	dimon.zhao@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	corbet@lwn.net,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 net-next 05/11] net/nebula-matrix: add channel layer
Date: Fri, 15 May 2026 18:17:13 -0700
Message-ID: <20260516011714.1863858-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513011649.4404-6-illusion.wang@nebula-matrix.com>
References: <20260513011649.4404-6-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8679C559BC6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nebula-matrix.com,vger.kernel.org,lunn.ch,lwn.net,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-288545-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ack_msgid.id:url]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/nebula-matrix: add channel layer

A channel management layer provides a structured approach to handle
communication between different components and drivers. It handles message
registration, message sending/acknowledgment, and queue management using
mailbox channels.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> index c1b724a8b92dd..8b178b8f6de3f 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c

[ ... ]

> +static int nbl_chan_teardown_queue(struct nbl_channel_mgt *chan_mgt,
> +				   u8 chan_type)
> +{
> +	struct nbl_chan_info *chan_info = chan_mgt->chan_info[chan_type];
> +
> +	cancel_work_sync(chan_info->clean_task);

Could this pointer be uninitialized? If nbl_chan_setup_queue() fails
early (for example, during buffer allocation), it calls this teardown
function, but the clean_task appears to only be registered externally later.
Would this pass a NULL pointer to cancel_work_sync() and cause a panic?

[ ... ]

> +static int nbl_chan_update_txqueue(struct nbl_channel_mgt *chan_mgt,
> +				   struct nbl_chan_info *chan_info,
> +				   struct nbl_chan_tx_param *param)
> +{
[ ... ]
> +	if (param->arg_len > NBL_CHAN_TX_DESC_EMBEDDED_DATA_LEN) {
> +		memcpy(tx_buf->va, param->arg, param->arg_len);
> +		tx_desc->buf_addr = cpu_to_le64(tx_buf->pa);
> +		tx_desc->buf_len = cpu_to_le16(param->arg_len);
> +		tx_desc->data_len = 0;
> +	} else {
> +		memcpy(tx_desc->data, param->arg, param->arg_len);
> +		tx_desc->buf_len = 0;
> +		tx_desc->data_len = cpu_to_le16(param->arg_len);
> +	}
> +	tx_desc->flags = cpu_to_le16(BIT(NBL_CHAN_TX_DESC_AVAIL));

Should there be a dma_wmb() before setting the AVAIL flag? Without a memory
barrier here, the CPU might reorder the flag write before the payload data
is fully committed, causing the hardware DMA engine to fetch an incomplete
descriptor.

[ ... ]

> +static int nbl_chan_kick_tx_ring(struct nbl_channel_mgt *chan_mgt,
> +				 struct nbl_chan_info *chan_info)
> +{
[ ... ]
> +	while (retry_count < max_retries) {
> +		if (le16_to_cpu(READ_ONCE(tx_desc->flags)) &
> +		    BIT(NBL_CHAN_TX_DESC_USED)) {
> +			dma_rmb();
> +			break;
> +		}
> +
> +		if (!(retry_count % NBL_CHAN_TX_REKICK_WAIT_TIMES))
> +			NBL_UPDATE_QUEUE_TAIL_PTR(chan_info, hw_ops, chan_mgt,
> +						  txq->tail_ptr, NBL_MB_TX_QID);
> +		retry_count++;
> +
> +		usleep_range(NBL_CHAN_TX_WAIT_US, NBL_CHAN_TX_WAIT_US_MAX);
> +	}
> +	if (retry_count >= max_retries) {
> +		dev_err(dev, "chan send message type: %d timeout\n",
> +			le16_to_cpu(READ_ONCE(tx_desc->msg_type)));
> +		return -ETIMEDOUT;
> +	}
> +	txq->next_to_clean = txq->next_to_use;

If a timeout happens, this returns -ETIMEDOUT without advancing
txq->next_to_clean. Won't this permanently wedge the TX queue, because the
next send operation will start polling the exact same stuck descriptor and
timeout again?

[ ... ]

> +static void nbl_chan_recv_ack_msg(void *priv, u16 srcid, u16 msgid, void *data,
> +				  u32 data_len)
> +{
[ ... ]
> +	if (ack_datalen > MAX_ACK_DATA_SIZE) {
> +		dev_err(dev, "Invalid loc=%d\n", ack_msgid.info.loc);
> +		return;
> +	}
> +	ack_msgid.id = *(u16 *)(payload + NBL_CHAN_MSG_ID_POS);

Doesn't the error log above print an uninitialized value? The ack_msgid
union is populated on the line right after it is logged, so it will always
print the zero-initialized default value.

Also, is it safe to read the msgid by casting the payload pointer like this?
Since the sender stores a 16-bit msgid into a 32-bit array natively, casting
to a u16 pointer will read the upper 16 bits of the 32-bit word on big-endian
architectures. That would result in a message ID of 0 and break the ACK
mechanism.

[ ... ]
> +	wait_head->ack_err = *(payload + NBL_CHAN_ACK_RET_POS);
> +
> +	copy_len = min_t(u32, wait_head->ack_data_len, ack_datalen);
> +	if (wait_head->ack_err >= 0 && copy_len > 0) {
> +		if (NBL_CHAN_ACK_HEAD_LEN * sizeof(u32) + copy_len > data_len) {
> +			dev_err(dev, "ACK payload overflow\n");
> +			return;
> +		}
> +		memcpy((char *)wait_head->ack_data,
> +		       payload + NBL_CHAN_ACK_HEAD_LEN, copy_len);
> +		wait_head->ack_data_len = (u16)copy_len;
> +	} else {
> +		wait_head->ack_data_len = 0;
> +	}

Can this memcpy() race with the timeout path in nbl_chan_send_msg()? The
receiver checks wait_head->status earlier without holding locks. If
nbl_chan_send_msg() times out immediately after that check, it sets
wait_head->ack_data to NULL and returns, freeing its local buffer. The
receiver might then resume and execute this memcpy into a NULL pointer or a
freed stack frame.

[ ... ]

> +static void nbl_chan_recv_msg(struct nbl_channel_mgt *chan_mgt, void *data)
> +{
[ ... ]
> +	if (tx_desc->data_len) {
> +		payload_len = le16_to_cpu(tx_desc->data_len);
> +		if (payload_len > NBL_CHAN_TX_DESC_DATA_LEN) {
> +			dev_err(dev, "data_len=%u exceeds embedded buffer size=%u\n",
> +				payload_len,
> +				NBL_CHAN_TX_DESC_DATA_LEN);
> +			return;
> +		}
> +		payload = tx_desc->data;
> +	} else {
> +		payload_len = le16_to_cpu(tx_desc->buf_len);
> +		if (payload_len > NBL_CHAN_BUF_LEN) {
> +			dev_err(dev, "buf_len=%u exceeds external buffer size=%u\n",
> +				payload_len,
> +				NBL_CHAN_BUF_LEN);
> +			return;
> +		}
> +		payload = tx_desc + 1;
> +	}

Could this result in an out-of-bounds access? The external buffer payload
pointer starts at tx_desc + 1 (an offset of sizeof(struct nbl_chan_tx_desc),
which is 64 bytes). If payload_len is between 4033 and 4096,
payload + payload_len will exceed the total NBL_CHAN_BUF_LEN of 4096 bytes,
overflowing the buffer boundary.

[ ... ]

> +static int nbl_chan_send_msg(struct nbl_channel_mgt *chan_mgt,
> +			     struct nbl_chan_send_info *chan_send)
> +{
[ ... ]
> +	/*polling wait mailbox ack*/
> +	mutex_lock(&chan_info->txq_lock);
> +	while (i--) {
> +		nbl_chan_clean_queue(chan_mgt, chan_info);
> +
> +		if (wait_head->acked) {
> +			chan_send->ack_len = wait_head->ack_data_len;
> +			atomic_set(&wait_head->status, NBL_MBX_STATUS_IDLE);
> +			ret = READ_ONCE(wait_head->ack_err);
> +			mutex_unlock(&chan_info->txq_lock);
> +			return ret;
> +		}

Are we missing a read memory barrier here? The receiver uses a wmb() before
setting wait_head->acked = 1, but the polling loop lacks a corresponding rmb()
after observing the flag. The CPU could reorder the reads, causing this code
to read stale values for ack_data_len or ack_err.

Also, is it possible for this polling loop to self-deadlock? The loop holds
txq_lock while calling nbl_chan_clean_queue(), which processes incoming
messages. If an incoming message requires an ACK, its handler will call
nbl_chan_send_ack(), which eventually calls nbl_chan_send_msg() again and
will attempt to reacquire the non-recursive txq_lock.

[ ... ]

> +static int nbl_chan_send_ack(struct nbl_channel_mgt *chan_mgt,
> +			     struct nbl_chan_ack_info *chan_ack)
> +{
> +	u32 len = NBL_CHAN_ACK_HEAD_LEN * sizeof(u32) + chan_ack->data_len;

Does this calculation have an integer overflow issue? A sufficiently large
chan_ack->data_len could cause len to wrap around, leading to a tiny heap
allocation. The subsequent memcpy() would then write past the end of the buffer.

[ ... ]

> +int nbl_chan_init_common(struct nbl_adapter *adap)
> +{
[ ... ]
> +	chan_ops_tbl = nbl_chan_setup_ops(dev, chan_mgt);
> +	if (IS_ERR(chan_ops_tbl)) {
> +		ret = PTR_ERR(chan_ops_tbl);
> +		goto exit;
> +	}
> +	adap->intf.channel_ops_tbl = chan_ops_tbl;
> +
> +	return 0;
> +
> +exit:
> +	if (chan_mgt) {
> +		nbl_chan_remove_msg_handler(chan_mgt);
> +		 adap->core.chan_mgt = NULL;
> +	}

Will this cause a panic if nbl_chan_setup_chan_mgt() returns an ERR_PTR?
The condition if (chan_mgt) will evaluate to true for an error pointer, and
nbl_chan_remove_msg_handler() will dereference it. A check like
!IS_ERR_OR_NULL(chan_mgt) might be safer here.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
> new file mode 100644
> index 0000000000000..79c1d5f5aacf9
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c

[ ... ]

> +void nbl_common_destroy_wq(void)
> +{
> +	destroy_workqueue(wq_mgt->ctrl_dev_wq);
> +	kfree(wq_mgt);
> +	wq_mgt = NULL;
> +}

Is it possible that wq_mgt is NULL here? If nbl_common_create_wq() fails to
allocate the workqueue, it frees wq_mgt and sets it to NULL. A subsequent
cleanup call to nbl_common_destroy_wq() would unconditionally dereference it.

[ ... ]

> +int nbl_common_alloc_hash_node(struct nbl_hash_tbl_mgt *tbl_mgt, void *key,
> +			       void *data, void **out_data)
> +{
[ ... ]
> +	hash_val = nbl_common_calc_hash_key(key, key_size,
> +					    tbl_mgt->tbl_key.bucket_size);
> +
> +	hlist_add_head(&hash_node->node, tbl_mgt->hash + hash_val);
> +	tbl_mgt->node_num++;
> +	if (out_data)
> +		*out_data = hash_node->data;
> +
> +	return 0;

[ ... ]

> +void *nbl_common_get_hash_node(struct nbl_hash_tbl_mgt *tbl_mgt, void *key)
> +{
[ ... ]
> +	hlist_for_each_entry(hash_node, head, node)
> +		if (!memcmp(hash_node->key, key, key_size)) {
> +			data = hash_node->data;
> +			break;
> +		}
> +
> +	return data;
> +}

Is there a synchronization issue with this hash table implementation? The
code modifies and traverses the hlist without any locking or RCU protection.
Concurrent message registration and reception could corrupt the linked list.

