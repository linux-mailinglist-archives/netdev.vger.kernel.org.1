Return-Path: <netdev+bounces-283019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOB1N5vq82kV8wEAu9opvQ
	(envelope-from <netdev+bounces-283019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 01:49:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7FC4A8F50
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 01:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42EC9304EAB3
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 23:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CED3DB625;
	Thu, 30 Apr 2026 23:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyJb1ayQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31773D9045;
	Thu, 30 Apr 2026 23:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777592872; cv=none; b=Qfckwl2CJXQE4e74h2RHqBwh6bbfRYaRysN4dXbJegu3bFSY0Rs7bAI29OEXYMyKT+T8DZvkNgM91dX+0hYnEph6akTER94dj6dXBd7j/ywn5hTKYDZztamSdKa9KwRVn0ZtLW9JCTtBRMS6d29yTrllhG+iigeUFkDHliwmhYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777592872; c=relaxed/simple;
	bh=7Y5ArivQ0VAWoanzu0YhtRHc08gqFgJNnbCruxKntoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDicHvUxn+HbCPWFZS8aDQb4zfUNTkKJ8Keja5ELIZUFAe5YrGMwSOAZEYMrF/GqxtEDsZ2jnhiqR0dBEcc7gSX5MvQWT7zziYqeSQc+ZE2G4UvXucCElFMSDVNTwYS5GAP9L62zCfG9lDwmT+WbPvMqp87PYGePCZor3fkHDDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyJb1ayQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67009C2BCB3;
	Thu, 30 Apr 2026 23:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777592872;
	bh=7Y5ArivQ0VAWoanzu0YhtRHc08gqFgJNnbCruxKntoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iyJb1ayQdt6BvuQfdRcORpvvFaRsRTkel3apIqshyM+0hNF6PlWF8ZrekPoIqkqTm
	 6ONt6e0nV4WrlZE6TfWmhJq58xQw1+YS0Xdl413cUUi617dJkNomE1cb4ouFO9KMiF
	 HekO8nda/orXazOfZzj5SPbo3LxVNcf5WhFHnFL+tX4nsIzpwW7WD5H+KyoRgXdHhe
	 7ImcUJODxn6nk4QkgacCSfvChX7rLPFxrs5Ny6JTg9qMypf2/ugulvWCnM4LgVOojB
	 7lNo1ZVyWPOc0Rdh9C8ESif0I5hzY8jXDtxg+XiQ+Ytt/bhXCAbCnEVdlg/5Jjk4r9
	 Fjq15RxU5PazA==
From: Jakub Kicinski <kuba@kernel.org>
To: illusion.wang@nebula-matrix.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	dimon.zhao@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	lorenzo@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 net-next 09/11] net/nebula-matrix: add Dispatch layer implementation
Date: Thu, 30 Apr 2026 16:47:50 -0700
Message-ID: <20260430234750.3074728-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428114910.2616-10-illusion.wang@nebula-matrix.com>
References: <20260428114910.2616-10-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7F7FC4A8F50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283019-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nebula-matrix.com,vger.kernel.org,lunn.ch,lwn.net,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/nebula-matrix: add Dispatch layer implementation

This patch adds the dispatch layer, which either routes an op directly to
the resource layer or sends a channel message, selected by a per-op control
level bitmap populated at init based on has_ctrl / has_net flags. A set of
channel request/response handlers is introduced for init/deinit of chip
modules, MSIX map configuration, mailbox IRQ enable, and VSI/ETH id
lookup.

A few questions below.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> index 281d33051185..caf99dd93338 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> @@ -6,6 +6,396 @@
> +static u16 nbl_disp_chan_get_vsi_id_req(struct nbl_dispatch_mgt *disp_mgt,
> +					u16 type)
> +{
> +	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
> +	struct nbl_common_info *common = disp_mgt->common;
> +	struct nbl_chan_param_get_vsi_id result = { 0 };
> +	struct nbl_chan_param_get_vsi_id param = { 0 };
> +	struct nbl_chan_send_info chan_send;
> +
> +	param.type = type;
> +
> +	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_GET_VSI_ID,
> +		      &param, sizeof(param), &result, sizeof(result), 1);
> +	chan_ops->send_msg(disp_mgt->chan_ops_tbl->priv, &chan_send);
> +
> +	return result.vsi_id;
> +}

The return value of chan_ops->send_msg() is discarded here, and the
zero-initialized result is returned on failure.

Combined with NBL_OPS_CALL_RET returning 0 when the op pointer is NULL,
can callers tell a mailbox timeout (e.g. -ETIMEDOUT) apart from a valid
vsi_id of 0 or from an op that was not implemented?

The same pattern appears in nbl_disp_chan_get_eth_id_req() below, where
send_msg() failure yields eth_mode=0, eth_id=0, logic_eth_id=0, which are
then fed into subsequent MSIX/VSI configuration.

> +static void nbl_disp_chan_get_vsi_id_resp(void *priv, u16 src_id, u16 msg_id,
> +					  void *data, u32 data_len)
> +{
> +	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
> +	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
> +	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
> +	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
> +	struct device *dev = disp_mgt->common->dev;
> +	struct nbl_chan_param_get_vsi_id *param;
> +	struct nbl_chan_param_get_vsi_id result = { 0 };
> +	struct nbl_chan_ack_info chan_ack;
> +	int err = NBL_CHAN_RESP_OK;
> +	int ret;
> +
> +	param = (struct nbl_chan_param_get_vsi_id *)data;
> +
> +	result.vsi_id =
> +		NBL_OPS_CALL_RET(res_ops->get_vsi_id, (p, src_id, param->type));

The incoming data buffer is cast to the parameter struct and param->type is
dereferenced without checking data_len against sizeof(*param).

If a peer sends a truncated NBL_CHAN_MSG_GET_VSI_ID payload, can this read
past the end of the buffer?

The same question applies to nbl_disp_chan_get_eth_id_resp(),
nbl_disp_chan_configure_msix_map_resp(),
nbl_disp_chan_destroy_msix_map_resp() (which at least has no param deref),
and nbl_disp_chan_enable_mailbox_irq_resp() below, which all do the same
unchecked cast on the peer-supplied payload before driving privileged
resource ops such as configure_msix_map and enable_mailbox_irq.

[ ... ]

> +static int nbl_disp_configure_msix_map(struct nbl_dispatch_mgt *disp_mgt,
> +				       u16 num_net_msix, u16 num_others_msix,
> +				       bool net_msix_mask_en)
> +{
> +	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
> +	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
> +
> +	return NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->configure_msix_map, p,
> +				     0, num_net_msix, num_others_msix,
> +				     net_msix_mask_en);
> +}

configure_msix_map, destroy_msix_map and enable_mailbox_irq call into
res_ops under disp_mgt->ops_mutex_lock, but init_chip_module,
deinit_chip_module, get_vsi_id and get_eth_id (and their _resp twins) call
into the same res_ops without taking the mutex.

Is the mutex meant to serialize shared state in the resource layer?  If
yes, are the unlocked call sites racy against the locked ones; if no, is
the lock needed at all?

[ ... ]

> +static int
> +nbl_disp_chan_configure_msix_map_req(struct nbl_dispatch_mgt *disp_mgt,
> +				     u16 num_net_msix, u16 num_others_msix,
> +				     bool net_msix_mask_en)
> +{
> +	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
> +	struct nbl_common_info *common = disp_mgt->common;
> +	struct nbl_chan_param_cfg_msix_map param = { 0 };
> +	struct nbl_chan_send_info chan_send;
> +
> +	param.num_net_msix = num_net_msix;
> +	param.num_others_msix = num_others_msix;
> +	param.msix_mask_en = net_msix_mask_en;

The dispatch API and the resource op take net_msix_mask_en as bool, but
nbl_chan_param_cfg_msix_map.msix_mask_en is u16 on the wire:

    struct nbl_chan_param_cfg_msix_map {
            u16 num_net_msix;
            u16 num_others_msix;
            u16 msix_mask_en;
    };

Any non-zero u16 (including garbage in the high bits from a misbehaving
peer) is then treated as true on the receiving side without a !! before
it is handed to res_ops->configure_msix_map.  Is that intentional?

[ ... ]

> +/* NBL_DISP_SET_OPS(disp_op_name, func, ctrl_lvl, msg_type, msg_req, msg_resp)
> + * ctrl_lvl is to define when this disp_op should go directly to res_op,
> + * not sending a channel msg.
> + * Use X Macros to reduce codes in channel_op and disp_op setup/remove
> + */
> +#define NBL_DISP_OPS_TBL						\
> +do {									\
> +	NBL_DISP_SET_OPS(init_chip_module, nbl_disp_init_chip_module,	\
> +			 NBL_DISP_CTRL_LVL_MGT, -1, NULL, NULL);	\
> +	NBL_DISP_SET_OPS(deinit_chip_module,				\
> +			 nbl_disp_deinit_chip_module,			\
> +			 NBL_DISP_CTRL_LVL_MGT, -1, NULL, NULL);	\
> +	NBL_DISP_SET_OPS(configure_msix_map,				\
> +			 nbl_disp_configure_msix_map,			\
> +			 NBL_DISP_CTRL_LVL_MGT,				\
> +			 NBL_CHAN_MSG_CONFIGURE_MSIX_MAP,		\
> +			 nbl_disp_chan_configure_msix_map_req,		\
> +			 nbl_disp_chan_configure_msix_map_resp);	\
> +	NBL_DISP_SET_OPS(destroy_msix_map, nbl_disp_destroy_msix_map,	\
> +			 NBL_DISP_CTRL_LVL_MGT,				\
> +			 NBL_CHAN_MSG_DESTROY_MSIX_MAP,			\
> +			 nbl_disp_chan_destroy_msix_map_req,		\
> +			 nbl_disp_chan_destroy_msix_map_resp);		\
> +	NBL_DISP_SET_OPS(enable_mailbox_irq,				\
> +			 nbl_disp_enable_mailbox_irq,			\
> +			 NBL_DISP_CTRL_LVL_MGT,				\
> +			 NBL_CHAN_MSG_MAILBOX_ENABLE_IRQ,		\
> +			 nbl_disp_chan_enable_mailbox_irq_req,		\
> +			 nbl_disp_chan_enable_mailbox_irq_resp);	\
> +	NBL_DISP_SET_OPS(get_vsi_id, nbl_disp_get_vsi_id,		\
> +			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_GET_VSI_ID,\
> +			 nbl_disp_chan_get_vsi_id_req,			\
> +			 nbl_disp_chan_get_vsi_id_resp);		\
> +	NBL_DISP_SET_OPS(get_eth_id, nbl_disp_get_eth_id,		\
> +			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_GET_ETH_ID,\
> +			 nbl_disp_chan_get_eth_id_req,			\
> +			 nbl_disp_chan_get_eth_id_resp);		\
> +} while (0)

The commit message describes the routing mechanism using a "Regular PF"
example that direct-dispatches NET_LVL ops while channel-dispatching
CTRL_LVL (management) ops:

    Regular PF
    Configures 'NET_LVL' at Dispatch layer
      All 'NET_LVL' operations use direct path; 'CTRL_LVL' operations go via channel.

Every entry in NBL_DISP_OPS_TBL, however, declares NBL_DISP_CTRL_LVL_MGT,
and no entry declares NBL_DISP_CTRL_LVL_NET.  Is the has_net /
NBL_DISP_CTRL_LVL_NET branch in nbl_disp_init() reachable by any op as
submitted, or is the NET_LVL half of the feature not yet wired up?

> +/* Structure starts here, adding an op should not modify anything below */
> +static int nbl_disp_setup_msg(struct nbl_dispatch_mgt *disp_mgt)
> +{
> +	struct nbl_dispatch_ops *disp_ops = disp_mgt->disp_ops_tbl->ops;
> +	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
> +	struct nbl_channel_mgt *p = disp_mgt->chan_ops_tbl->priv;
> +	int ret = 0;
> +
> +	mutex_init(&disp_mgt->ops_mutex_lock);
> +
> +#define NBL_DISP_SET_OPS(disp_op, func, ctrl, msg_type, msg_req, resp) \
> +do {									\
> +	typeof(msg_type) _msg_type = (msg_type);			\
> +	typeof(ctrl) _ctrl_lvl = (ctrl);				\
> +	(void)(disp_ops->NBL_NAME(disp_op));				\
> +	(void)(func);							\
> +	(void)(msg_req);						\
> +	(void)_ctrl_lvl;						\
> +	if (_msg_type >= 0)						\
> +		ret += chan_ops->register_msg(p, _msg_type, resp, disp_mgt);\
> +} while (0)
> +	NBL_DISP_OPS_TBL;
> +#undef  NBL_DISP_SET_OPS
> +
> +	return ret;
> +}

Two questions about this helper.

First, the return codes of the individual register_msg() calls are summed
with "ret += chan_ops->register_msg(...)".  If two registrations return
-ENOMEM, the summed result is -24 (which is -EMFILE), and in general a
sum of negative errnos does not map back to any single defined error.  Is
an early-return-on-first-error pattern intended here instead?

Second, mutex_init() and every successful chan_ops->register_msg() install
state into the channel layer with disp_mgt as priv, but nbl_disp_remove()
is currently an empty stub:

    void nbl_disp_remove(struct nbl_adapter *adapter)
    {
    }

On driver unload or on any later probe failure path that tears the
adapter down, is there a matching unregister_msg() for each handler
installed here, and a matching mutex_destroy()?

If nbl_disp_setup_msg() partially succeeds and then fails mid-way, is the
partially installed handler table also rolled back before nbl_disp_init()
returns an error to its caller?  Handlers left registered would retain
disp_mgt as priv and would be invoked on the next incoming message.

> +/* Ctrl lvl means that if a certain level is set, then all disp_ops that
> + * decleared this lvl will go directly to res_ops, rather than send a
                ^^^^^^^^^
Minor: typo, should be "declared".

> + * channel msg, and vice versa.
> + */
> +static int nbl_disp_setup_ctrl_lvl(struct nbl_dispatch_mgt *disp_mgt, u32 lvl)
> +{
> +	struct nbl_dispatch_ops *disp_ops = disp_mgt->disp_ops_tbl->ops;
> +
> +	set_bit(lvl, disp_mgt->ctrl_lvl);
> +
> +#define NBL_DISP_SET_OPS(disp_op, func, ctrl, msg_type, msg_req, msg_resp) \
> +do {									\
> +	typeof(msg_type) _msg_type = (msg_type);			\
> +	(void)(_msg_type);						\
> +	(void)(msg_resp);						\
> +	disp_ops->NBL_NAME(disp_op) =					\
> +		test_bit(ctrl, disp_mgt->ctrl_lvl) ? func : msg_req;	\
> +} while (0)
> +	NBL_DISP_OPS_TBL;
> +#undef  NBL_DISP_SET_OPS
> +
> +	return 0;
> +}

nbl_disp_setup_ctrl_lvl() unconditionally returns 0, but all three call
sites in nbl_disp_init() below check "if (ret) return ret;" on the
return value:

> @@ -71,7 +461,25 @@ int nbl_disp_init(struct nbl_adapter *adapter)
> +	if (common->has_ctrl) {
> +		ret = nbl_disp_setup_ctrl_lvl(disp_mgt, NBL_DISP_CTRL_LVL_MGT);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (common->has_net) {
> +		ret = nbl_disp_setup_ctrl_lvl(disp_mgt, NBL_DISP_CTRL_LVL_NET);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = nbl_disp_setup_ctrl_lvl(disp_mgt, NBL_DISP_CTRL_LVL_ALWAYS);
> +
> +	return ret;
>  }

Is the fallible signature intentional, or should nbl_disp_setup_ctrl_lvl()
return void so these dead "if (ret)" checks can be dropped?

