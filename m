Return-Path: <netdev+bounces-270658-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FB3Oi6MwWlxTwQAu9opvQ
	(envelope-from <netdev+bounces-270658-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:53:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCB52FBA62
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C6B5F3024405
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7A93CCFB3;
	Mon, 23 Mar 2026 18:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dP9SZooj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26E5387593
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 18:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774290245; cv=none; b=OfIGm3t+9nIteWoCJOEFyU9N8VmNNt4MWSG0SZHPs7MwTLLGwYwhzNd9mpjC9YlJPmz0+sbkT4PJAjPINLQobwZu5WAXn7o5m1Al2+mWsyFw1VH7+FeRHJ4Uhoxu3nXHUobG1kdZbqvtBqFvpGc7iPoVmhBM25J0cnO6intsjwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774290245; c=relaxed/simple;
	bh=yE5ilE3TQ1v/58GaQxDbErI6hd4AqAH42Q/CEz9GiGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWKpzpbttScvQNpaSgRi68iv8P0KX7mrQgsnsG92VwdwsHG+n63mw2GURJEl2Wrt01OoV1TtPzxu1BrFHroO1vy4eVP34xON0eW+MsH6oTw1QBXf9yr4JMl9Y/oqzeJjAyQLf/+Rg4Z/2RyXF7LDqv8quM+3jtQSnukAfsCB4Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dP9SZooj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2316C4CEF7;
	Mon, 23 Mar 2026 18:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774290245;
	bh=yE5ilE3TQ1v/58GaQxDbErI6hd4AqAH42Q/CEz9GiGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dP9SZoojeMfKlvjuR8FaN/3MfyjsYNVFtcrkvuiB1g1g/vJ12on/GASiDHGFPmp0P
	 rZpHLciPKKxzhaIzTEf8khL0NT48qzHcVNN/nUdhOm/sp4HRMQ2pvgcbmukv/NTGRe
	 hMM4f5B1CyQpwJFodHuZPoxkSnKNdwT+0wiE3Y7KwNzh6SfeXBKRqFoIT4BGNvmzqs
	 33PdK+MWTcGL41lpS/95kofwQMgzivOaHJW0/SJtos/4BF22FCQpz70mM6cBGrwlso
	 naD/OE1+VK4CKWwKDZDpDRrs3TDQ/g1uQ4PYxJqLuxsb2IZbf1DUzv3+JwtEWEzntU
	 U+wsmlHd7R7Iw==
From: Simon Horman <horms@kernel.org>
To: weibunny.kernel@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	netdev@vger.kernel.org,
	weibunny@fb.com,
	daniel.zahka@gmail.com,
	bobbyeshleman@meta.com,
	kuba@kernel.org,
	davem@davemloft.net,
	dw@davidwei.uk,
	andrew+netdev@lunn.ch
Subject: Re: [PATCH v7 net-next 2/5] psp: add new netlink cmd for dev-assoc and dev-disassoc
Date: Mon, 23 Mar 2026 18:23:57 +0000
Message-ID: <20260323182357.177116-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260322040704.991766-3-weibunny.kernel@gmail.com>
References: <20260322040704.991766-3-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270658-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org,fb.com,meta.com,davemloft.net,davidwei.uk,lunn.ch];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 1DCB52FBA62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
psp: add new netlink cmd for dev-assoc and dev-disassoc

This commit adds new netlink commands (PSP_CMD_DEV_ASSOC and
PSP_CMD_DEV_DISASSOC) to associate non-PSP-capable devices (e.g. veth or
netkit) with a PSP device, enabling them to act as PSP-capable devices by
performing PSP encryption/decryption on the real PSP device.

> diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
> index 82de78a1d6bd..178b848989f1 100644
> --- a/net/psp/psp_main.c
> +++ b/net/psp/psp_main.c
> @@ -37,8 +37,18 @@ struct mutex psp_devs_lock;
>   */
>  int psp_dev_check_access(struct psp_dev *psd, struct net *net, bool admin)
>  {
> +	struct psp_assoc_dev *entry;
> +
>  	if (dev_net(psd->main_netdev) == net)
>  		return 0;
> +
> +	if (!admin) {
> +		list_for_each_entry(entry, &psd->assoc_dev_list, dev_list) {
> +			if (dev_net(entry->assoc_dev) == net)
> +				return 0;
> +		}
> +	}
> +
>  	return -ENOENT;
>  }

Does this list iteration have a race with psp_dev_unregister()?

The new list_for_each_entry iteration over psd->assoc_dev_list in
psp_dev_check_access is called from psp_assoc_device_get_locked
(net/psp/psp_nl.c:615) without holding psd->lock.

That caller obtains psd via psp_dev_get_for_sock which takes a refcount
but does not acquire psd->lock before calling psp_dev_check_access(psd,
..., false). Since admin is false, the new code path is entered.

Concurrently, psp_dev_unregister holds psd->lock and performs list_del +
kfree on the same assoc_dev_list entries:

net/psp/psp_main.c:psp_dev_unregister() {
	...
	list_for_each_entry_safe(entry, entry_tmp, &psd->assoc_dev_list,
				 dev_list) {
		list_del(&entry->dev_list);
		rcu_assign_pointer(entry->assoc_dev->psp_dev, NULL);
		netdev_put(entry->assoc_dev, &entry->dev_tracker);
		kfree(entry);
	}
	...
}

The list iterator in psp_dev_check_access can follow a next pointer into
freed memory, causing a use-after-free.

Other callers (psp_device_get_and_lock, psp_nl_dev_get_dumpit,
psp_nl_get_stats_dumpit) correctly hold psd->lock before calling this
function, so the race is specific to the psp_assoc_device_get_locked path.

> diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
> index b988f35412df..aa60a8277829 100644
> --- a/net/psp/psp_nl.c
> +++ b/net/psp/psp_nl.c

[ ... ]

> @@ -291,6 +446,140 @@ int psp_nl_key_rotate_doit(struct sk_buff *skb, struct genl_info *info)
>  	return err;
>  }
>
> +int psp_nl_dev_assoc_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct psp_dev *psd = info->user_ptr[0];
> +	struct psp_assoc_dev *psp_assoc_dev;
> +	struct net_device *assoc_dev;
> +	u32 assoc_ifindex;
> +	struct sk_buff *rsp;
> +	struct net *net;
> +	int nsid;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, PSP_A_DEV_IFINDEX))
> +		return -EINVAL;
> +
> +	if (info->attrs[PSP_A_DEV_NSID]) {
> +		nsid = nla_get_s32(info->attrs[PSP_A_DEV_NSID]);
> +
> +		net = get_net_ns_by_id(genl_info_net(info), nsid);
> +		if (!net) {
> +			NL_SET_BAD_ATTR(info->extack,
> +					info->attrs[PSP_A_DEV_NSID]);
> +			return -EINVAL;
> +		}
> +	} else {
> +		net = get_net(genl_info_net(info));
> +	}
> +
> +	psp_assoc_dev = kzalloc(sizeof(*psp_assoc_dev), GFP_KERNEL);
> +	if (!psp_assoc_dev) {
> +		put_net(net);
> +		return -ENOMEM;
> +	}
> +
> +	assoc_ifindex = nla_get_u32(info->attrs[PSP_A_DEV_IFINDEX]);
> +	assoc_dev = netdev_get_by_index(net, assoc_ifindex,
> +					&psp_assoc_dev->dev_tracker,
> +					GFP_KERNEL);
> +	if (!assoc_dev) {
> +		put_net(net);
> +		kfree(psp_assoc_dev);
> +		NL_SET_BAD_ATTR(info->extack, info->attrs[PSP_A_DEV_IFINDEX]);
> +		return -ENODEV;
> +	}
> +
> +	/* Check if device is already associated with a PSP device */
> +	if (rcu_access_pointer(assoc_dev->psp_dev)) {
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Device already associated with a PSP device");
> +		netdev_put(assoc_dev, &psp_assoc_dev->dev_tracker);
> +		put_net(net);
> +		kfree(psp_assoc_dev);
> +		return -EBUSY;
> +	}
> +
> +	psp_assoc_dev->assoc_dev = assoc_dev;
> +	rsp = psp_nl_reply_new(info);
> +	if (!rsp) {
> +		netdev_put(assoc_dev, &psp_assoc_dev->dev_tracker);
> +		put_net(net);
> +		kfree(psp_assoc_dev);
> +		return -ENOMEM;
> +	}
> +
> +	rcu_assign_pointer(assoc_dev->psp_dev, psd);
> +	list_add_tail(&psp_assoc_dev->dev_list, &psd->assoc_dev_list);

Can two concurrent PSP_CMD_DEV_ASSOC operations for the same net_device but
different PSP devices both succeed?

The function checks rcu_access_pointer(assoc_dev->psp_dev) to verify the
target net_device is not already associated with a PSP device, then later
writes rcu_assign_pointer(assoc_dev->psp_dev, psd) and adds the wrapper to
psd->assoc_dev_list.

These operations are only serialized by psd->lock, which is a per-PSP-device
mutex acquired by the pre_doit callback psp_device_get_locked(). With
parallel_ops=true in the psp_nl_family (net/psp/psp-nl-gen.c:165), two
concurrent PSP_CMD_DEV_ASSOC operations targeting different PSP devices
(each holding their own distinct psd->lock) but specifying the same target
ifindex can both pass the rcu_access_pointer() NULL check.

Both then call rcu_assign_pointer(assoc_dev->psp_dev, psd) and
list_add_tail(), resulting in the same net_device being added to two
different PSP devices' assoc_dev_list. The second rcu_assign_pointer
silently overwrites the first.

This leaves the first PSP device's assoc_dev_list containing an entry whose
net_device->psp_dev points to the wrong PSP device:

Thread A (PSP device psd_A)        Thread B (PSP device psd_B)
================================   ================================
mutex_lock(&psd_A->lock)           mutex_lock(&psd_B->lock)
rcu_access_pointer(dev->psp_dev)
  -> NULL, proceed                 rcu_access_pointer(dev->psp_dev)
                                     -> NULL, proceed
rcu_assign_pointer(dev->psp_dev,   rcu_assign_pointer(dev->psp_dev,
                   psd_A)                             psd_B)
list_add_tail(entry_A,             list_add_tail(entry_B,
              &psd_A->list)                      &psd_B->list)

A subsequent disassociation from the first PSP device would find its stale
psp_assoc_dev entry, call rcu_assign_pointer(found->assoc_dev->psp_dev,
NULL), and clear the pointer that now belongs to the second PSP device,
corrupting cross-device state.

The data path check in psp_validate_xmit
(rcu_access_pointer(dev->psp_dev) == pas->psd) can then fail incorrectly.

