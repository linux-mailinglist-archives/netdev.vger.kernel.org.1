Return-Path: <netdev+bounces-265795-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KuvGFdXr2lJUgIAu9opvQ
	(envelope-from <netdev+bounces-265795-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:27:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E48242A97
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E914305D1C9
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 23:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204963939C4;
	Mon,  9 Mar 2026 23:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwvMOwZr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AE3DDA9
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 23:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773098829; cv=none; b=e7RNvDKitTM7j7gGiHeiV4ka9v7C1i/eX3BvjfzqtX4ujJDff41jIt0omTFy5b6pG9eS049PJtAw2K0vHXGfdqoaCQ9qQpwhUYjVd4fZ9fzzOAiUR0BGQl3/RJrFeZfOVErQoYYCFNkOQbxsGqPtc8112jLzn0j3dp5CgvTiiHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773098829; c=relaxed/simple;
	bh=D1B5fR2Uo/LehN812bRO3d/ra5sdsK6c1HxWWqPufp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0IKpRe3we9QBxSGdaGXPoKGm+Asr/S2/sfaP/JwH13fSO8/qmsBZl3LUk3SPRTd6lmEj207Q3sDhZcu3G0Gfk0q7glCFaW70zf3S6q9XNigPsvdq0TEH8o8W3klAeiNIRNqOaDGSFZjzN7d9Rqlpe9NUL8tLNLQX96u6J6UHfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwvMOwZr; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4830f029407so17762785e9.2
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 16:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773098824; x=1773703624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q+/2uK9M8SvbNZPF7samxSviR5eCfgTMcqccGLDE+iw=;
        b=dwvMOwZrcT+l2O1EHf0f25e40Sk5ccjPUggKTf16C3sWhzvIQXuqOe0CoLPYbhIlGv
         /Z1q+jvhmMEFKxFwJRjXMj9ojemnmfPxjAUdrDTDPi66vxhl/2Ev2BThlRcWJ6Lppixn
         wQ2BRPrm3L1et4qxQKAr9uCUtmgyvLUYUUqr8V/h5JVo3adoPWC1X7hG5tS6Qy74mKNl
         EB2vMV2YH8IiUP47L6BH1farwovyjX7o19rnkdPGYrwA77VcmUS1CGAEdSsw3E4Aiu2n
         UNbyiCBhYM58t0KxvPLLyf7bRDfo0aj58hyea5SM01BEgvaGJ95A4zkMCyHTJTuPUJDl
         k3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773098824; x=1773703624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+/2uK9M8SvbNZPF7samxSviR5eCfgTMcqccGLDE+iw=;
        b=m4XZZVO5lEvELt2ArY63uklV+p/T54assc8nKxQfF6R1NN6GByuOcgwwo83C4aB3cw
         9MxkmKUBq9rSAYOYIT5gikeTJ/jF8eim7gF0mhx0H/n/+iCMpx00XrEA07zS5ZBflT10
         7bK8miypFvlruWrjuWgiJ7B24+yCDWHjc650LS08/8ebA+7+0OWnfA46ztHSnnH9pgZs
         AOiACJ3VaijH8BJNDbVXyREguhRWTo9xyciKdD0UzyOHL2R96Z5iRZndMMm/QsEWudCn
         suG3yqddc0SQ9g+/DObn0cEdEqofMNtNtMf0wev4B/vbGTskDEZeAjIpCeYxRaD+ZDog
         o68A==
X-Forwarded-Encrypted: i=1; AJvYcCVLgrpfZqkJPz1TCQxbQA08iXvTjE6biMqlWe7244ROZ+S9qVtPll52hp2rNSpTIEiuy/7b9ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS/IpOHZBvKl5UvvOQkLjC7CnEVaU8T28vLbWUm5nGh6GgEKSH
	ealp8D4FDlWAvod6C1D+D7EN6UfL7BqN8xpgzj3N53grX55uNQQGgsEH
X-Gm-Gg: ATEYQzwMx36CdQJ82zUdXrLkP0xZkjsU7FVv4L52yTpqGGw+s/9uoxgYt8+N1QelkC9
	sCgUciLL/bXTVXaWu+D763PVImg4swGA9SaYW6Fy/lydzWQogHM8Q9RUk3Z8EF1Tq3TdNNEagYt
	kCVJkvmsK1rjtIPTJ3kjCFW2rH6fq+YreCU4M2K52Fmk63dsY4E5//p7RhSTeKVXRoPV82l/Zwo
	mLTNgHNbdon0v4q2BQawooHAsLoMuL1EuaW4ZAjuCLkCN8xinSXsPaOcNYAH/74fBYYxYiP8jYl
	yHm9Qt/ey+XzT3GjlQGwB6j0fXkfYszeRZFEGODFIKv3JWzS/yzMIb9Nn3jd72EISG5KYVrarSh
	EWZ0LDqzIEUgjuxq/DDaA2W9a1SyzHv2aZ36PsPztLtvU1olvB7RpbV/5fyI17Y+JQuYWqtrTNP
	OoKF3gHT3SNZXjPw==
X-Received: by 2002:a05:600c:350e:b0:483:7d93:9f8a with SMTP id 5b1f17b1804b1-48526916b0dmr133421335e9.1.1773098824135;
        Mon, 09 Mar 2026 16:27:04 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d00a:e00:8799:3a7d:3c86:3200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485354f96fesm55114875e9.30.2026.03.09.16.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 16:27:03 -0700 (PDT)
Date: Tue, 10 Mar 2026 01:27:00 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Frank Wunderlich <frankwu@gmx.de>,
	Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next 2/2] net: dsa: mxl862xx: implement bridge
 offloading
Message-ID: <20260309232700.vaawcbfj6gbjncs4@skbuf>
References: <cover.1772853341.git.daniel@makrotopia.org>
 <cover.1772853341.git.daniel@makrotopia.org>
 <8aebab4c4bffa7e756ffbad4e9c9c8160773dd1a.1772853341.git.daniel@makrotopia.org>
 <8aebab4c4bffa7e756ffbad4e9c9c8160773dd1a.1772853341.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aebab4c4bffa7e756ffbad4e9c9c8160773dd1a.1772853341.git.daniel@makrotopia.org>
 <8aebab4c4bffa7e756ffbad4e9c9c8160773dd1a.1772853341.git.daniel@makrotopia.org>
X-Rspamd-Queue-Id: F2E48242A97
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265795-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Mar 07, 2026 at 03:31:17AM +0000, Daniel Golle wrote:
> +static int mxl862xx_update_bridge(struct dsa_switch *ds,
> +				  struct mxl862xx_bridge *mxlbridge,
> +				  int port, bool join)

There's a lot of false sharing here. If you move the "if (join)" and
"if (!join)" blocks to their respective callers, you end up with a much
smaller truly common function.

> +{
> +	struct mxl862xx_priv *priv = ds->priv;
> +	struct dsa_port *dp;
> +	int member, ret;
> +
> +	if (join) {
> +		__set_bit(port, mxlbridge->portmap);
> +		priv->ports[port].bridge = mxlbridge;
> +	} else {
> +		__clear_bit(port, mxlbridge->portmap);
> +		priv->ports[port].bridge = NULL;
> +	}
> +
> +	/* Update all current bridge members' portmaps */
> +	for_each_set_bit(member, mxlbridge->portmap,
> +			 MXL862XX_MAX_BRIDGE_PORTS) {
> +		dp = dsa_to_port(ds, member);
> +
> +		/* Build portmap: CPU port + all bridge members except self */
> +		bitmap_copy(priv->ports[member].portmap, mxlbridge->portmap,
> +			    MXL862XX_MAX_BRIDGE_PORTS);
> +		__clear_bit(member, priv->ports[member].portmap);
> +		__set_bit(dp->cpu_dp->index, priv->ports[member].portmap);
> +
> +		priv->ports[member].learning = true;

Actually, dsa_port_inherit_brport_flags() / dsa_port_clear_brport_flags() ensures
the BR_LEARNING flag passed through mxl862xx_port_bridge_flags() will keep the
hardware in sync with the bridge. You don't need to set this to true or to false
at runtime. Just at initial probe time, before DSA has made any call.

> +		ret = mxl862xx_set_bridge_port(ds, member);
> +		if (ret)
> +			return ret;

What about going through all ports anyway, and return error at the end
if any bridge member portmap update failed? I know this patch set is
written assuming FW I/O failure is catastrophic, but here you may be
failing for a different port than the one which is leaving the bridge.
You can at least make an attempt to disable forwarding to/from that port.

> +	}
> +
> +	/* Revert leaving port to its single-port bridge */
> +	if (!join) {
> +		dp = dsa_to_port(ds, port);
> +
> +		bitmap_zero(priv->ports[port].portmap, MXL862XX_MAX_BRIDGE_PORTS);
> +		__set_bit(dp->cpu_dp->index, priv->ports[port].portmap);
> +		priv->ports[port].flood_block = 0;
> +		priv->ports[port].learning = false;
> +		ret = mxl862xx_set_bridge_port(ds, port);
> +		if (ret)
> +			return ret;
> +
> +		mxl862xx_port_fast_age(ds, port);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mxl862xx_port_bridge_join(struct dsa_switch *ds, int port,
> +				     struct dsa_bridge bridge,
> +				     bool *tx_fwd_offload,
> +				     struct netlink_ext_ack *extack)
> +{
> +	struct mxl862xx_bridge *mxlbridge;
>  
> -	return MXL862XX_API_WRITE(ds->priv, MXL862XX_BRIDGEPORT_CONFIGSET, br_port_cfg);
> +	mxlbridge = mxl862xx_find_bridge(ds, bridge);
> +	if (!mxlbridge) {
> +		mxlbridge = mxl862xx_allocate_bridge(ds, bridge.num);
> +		if (IS_ERR(mxlbridge))
> +			return PTR_ERR(mxlbridge);
> +	}
> +
> +	return mxl862xx_update_bridge(ds, mxlbridge, port, true);
> +}
> +
> +static void mxl862xx_port_bridge_leave(struct dsa_switch *ds, int port,
> +				       struct dsa_bridge bridge)
> +{
> +	struct mxl862xx_bridge *mxlbridge;
> +
> +	mxlbridge = mxl862xx_find_bridge(ds, bridge);
> +	if (!mxlbridge)
> +		return;
> +
> +	mxl862xx_update_bridge(ds, mxlbridge, port, false);

Don't let this fail silently.

> +
> +	if (bitmap_empty(mxlbridge->portmap, MXL862XX_MAX_BRIDGE_PORTS))
> +		mxl862xx_free_bridge(ds, mxlbridge);
>  }
>  
>  static int mxl862xx_port_setup(struct dsa_switch *ds, int port)
> @@ -366,6 +614,262 @@ static void mxl862xx_phylink_get_caps(struct dsa_switch *ds, int port,
>  		  config->supported_interfaces);
>  }
>  
> +static int mxl862xx_port_fdb_add(struct dsa_switch *ds, int port,
> +				 const unsigned char *addr, u16 vid, struct dsa_db db)
> +{
> +	struct mxl862xx_mac_table_add param = { };
> +	struct mxl862xx_priv *priv = ds->priv;
> +	struct mxl862xx_bridge *mxlbridge;
> +	u16 fid;
> +	int ret;
> +
> +	switch (db.type) {
> +	case DSA_DB_PORT:
> +		fid = priv->ports[db.dp->index].fid;
> +		break;
> +
> +	case DSA_DB_BRIDGE:
> +		mxlbridge = mxl862xx_find_bridge(ds, db.bridge);
> +		if (!mxlbridge)
> +			return -ENOENT;
> +		fid = mxlbridge->bridge_id;
> +		break;
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	param.port_id = cpu_to_le32(port);
> +	param.fid = cpu_to_le16(fid);
> +	param.static_entry = true;
> +	param.tci = cpu_to_le16(vid & 0xFFF);
> +	memcpy(param.mac, addr, ETH_ALEN);

ether_addr_copy() - similar comment for port_fdb_del()

> +
> +	ret = MXL862XX_API_WRITE(priv, MXL862XX_MAC_TABLEENTRYADD, param);
> +	if (ret)
> +		dev_err(ds->dev, "failed to add FDB entry on port %d\n", port);
> +
> +	return ret;
> +}
> +
> +static int mxl862xx_port_fdb_del(struct dsa_switch *ds, int port,
> +				 const unsigned char *addr, u16 vid, struct dsa_db db)
> +{
> +	struct mxl862xx_mac_table_remove param = { };
> +	struct mxl862xx_priv *priv = ds->priv;
> +	struct mxl862xx_bridge *mxlbridge;
> +	u16 fid;
> +	int ret;
> +
> +	switch (db.type) {
> +	case DSA_DB_PORT:
> +		fid = priv->ports[db.dp->index].fid;
> +		break;
> +
> +	case DSA_DB_BRIDGE:
> +		/* Use multi-port bridge FID */
> +		mxlbridge = mxl862xx_find_bridge(ds, db.bridge);
> +		if (!mxlbridge)
> +			return -ENOENT;
> +		fid = mxlbridge->bridge_id;
> +		break;
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}

Please group this together with the FID selection from port_fdb_add()
into a single helper.

> +
> +	param.fid = cpu_to_le16(fid);
> +	param.tci = cpu_to_le16(vid & 0xFFF);
> +	memcpy(param.mac, addr, ETH_ALEN);
> +
> +	ret = MXL862XX_API_WRITE(priv, MXL862XX_MAC_TABLEENTRYREMOVE, param);
> +	if (ret)
> +		dev_err(ds->dev, "failed to remove FDB entry on port %d\n", port);
> +
> +	return ret;
> +}
> +
> +static int mxl862xx_port_fdb_dump(struct dsa_switch *ds, int port,
> +				  dsa_fdb_dump_cb_t *cb, void *data)
> +{
> +	struct mxl862xx_mac_table_read param = { };
> +	struct mxl862xx_priv *priv = ds->priv;
> +	u32 entry_port_id;
> +	int ret;
> +
> +	while (true) {
> +		ret = MXL862XX_API_READ(priv, MXL862XX_MAC_TABLEENTRYREAD, param);
> +		if (ret)
> +			return ret;
> +
> +		if (param.last)
> +			break;
> +
> +		entry_port_id = le32_to_cpu(param.port_id);
> +
> +		if (entry_port_id == port)
> +			cb(param.mac, param.tci & 0x0FFF,
> +			   param.static_entry, data);

Catch and propagate the error from the FDB dump callback. See commit
21b52fed928e ("net: dsa: sja1105: fix broken backpressure in
.port_fdb_dump").

> +
> +		memset(&param, 0, sizeof(param));
> +	}
> +
> +	return 0;
> +}
> +
> +static int mxl862xx_port_mdb_add(struct dsa_switch *ds, int port,
> +				 const struct switchdev_obj_port_mdb *mdb,
> +				 struct dsa_db db)
> +{
> +	return mxl862xx_port_fdb_add(ds, port, mdb->addr, mdb->vid, db);
> +}
> +
> +static int mxl862xx_port_mdb_del(struct dsa_switch *ds, int port,
> +				 const struct switchdev_obj_port_mdb *mdb,
> +				 struct dsa_db db)
> +{
> +	return mxl862xx_port_fdb_del(ds, port, mdb->addr, mdb->vid, db);
> +}
> +
> +static int mxl862xx_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
> +{
> +	struct mxl862xx_cfg param;
> +	int ret;
> +
> +	ret = MXL862XX_API_READ(ds->priv, MXL862XX_COMMON_CFGGET, param);
> +	if (ret) {
> +		dev_err(ds->dev, "failed to read switch config\n");
> +		return ret;
> +	}
> +
> +	param.mac_table_age_timer = cpu_to_le32(MXL862XX_AGETIMER_CUSTOM);
> +	param.age_timer = cpu_to_le32(msecs / 1000);
> +	ret = MXL862XX_API_WRITE(ds->priv, MXL862XX_COMMON_CFGSET, param);
> +	if (ret)
> +		dev_err(ds->dev, "failed to set ageing\n");
> +
> +	return ret;
> +}
> +
> +static void mxl862xx_port_stp_state_set(struct dsa_switch *ds, int port,
> +					u8 state)
> +{
> +	struct mxl862xx_stp_port_cfg param = {
> +		.port_id = cpu_to_le16(port),
> +	};
> +	struct mxl862xx_priv *priv = ds->priv;
> +	int ret;
> +
> +	switch (state) {
> +	case BR_STATE_DISABLED:
> +		param.port_state = MXL862XX_STP_PORT_STATE_DISABLE;
> +		break;
> +	case BR_STATE_BLOCKING:
> +	case BR_STATE_LISTENING:
> +		param.port_state = MXL862XX_STP_PORT_STATE_BLOCKING;
> +		break;
> +	case BR_STATE_LEARNING:
> +		param.port_state = MXL862XX_STP_PORT_STATE_LEARNING;
> +		break;
> +	case BR_STATE_FORWARDING:
> +		param.port_state = MXL862XX_STP_PORT_STATE_FORWARD;
> +		break;
> +	default:
> +		dev_err(ds->dev, "invalid STP state: %d\n", state);
> +		return;
> +	}
> +
> +	ret = MXL862XX_API_WRITE(priv, MXL862XX_STP_PORTCFGSET, param);
> +	if (ret) {
> +		dev_err(ds->dev, "failed to set STP state on port %d\n", port);
> +		return;
> +	}
> +
> +	/* The firmware may re-enable MAC learning as a side-effect of
> +	 * entering LEARNING or FORWARDING state (per 802.1D defaults).
> +	 * Re-apply the driver's intended learning and metering config
> +	 * so that standalone ports keep learning disabled.
> +	 */
> +	ret = mxl862xx_set_bridge_port(ds, port);
> +	if (ret)
> +		dev_err(ds->dev, "failed to reapply brport flags on port %d\n", port);

Do you need to also manually fast-age the port if p->learning == false? Packets
may be coming in as soon as you put the port in MXL862XX_STP_PORT_STATE_LEARNING
already, and they will end up in the FDB even if from Linux' perspective,
it had learning off all along. It is a race condition.

> +}

