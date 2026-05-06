Return-Path: <netdev+bounces-284656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JhbBX2d+mk8QQMAu9opvQ
	(envelope-from <netdev+bounces-284656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:46:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2F54D565F
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5588F301F2A4
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 01:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E7C279358;
	Wed,  6 May 2026 01:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0eeGVlv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF71C26CE2C;
	Wed,  6 May 2026 01:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778031978; cv=none; b=GMcnLOvT28RXsi57P9/5HqMCIj53t98j0W1w/MYmxw4SmaDLUzhXsGmzNZrn7oRCj8nW/5IltnY5+eTnEK7/zCdie/AjnYwGoSCOSGwxbtzyla03NB9qVCOyjVbUvPCLzbiCmubLpmMFWiInz90Q7Rc5rZ/8Nl25/acYb3GQtxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778031978; c=relaxed/simple;
	bh=JC0cvTZZgqEs/UPOYBoj1eskFq+qoMwoWN6REo/8dlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyTGPCWS+uji3A0GJGn+Qys9Ta2wLoysMZ7I5f81jW1mf+uOdiU2QJIv0zrVkaqLHFx7f0yCGrNenqN6GdrYRl/r8nJdKY4PdoRAXKagWlwj4mvw9v8XYFgy3vD7YDiMG8BIaTlQaBjeQJO6cWRbLAsOydYFyTRkXJO487YRGZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0eeGVlv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA494C2BCC9;
	Wed,  6 May 2026 01:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778031976;
	bh=JC0cvTZZgqEs/UPOYBoj1eskFq+qoMwoWN6REo/8dlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F0eeGVlvDVcD3Qib47PzTGwYCI9eo4JpSL3rwnX9A4FSjRmfkL2ZIki0G4Gu1zXdU
	 J0S+n2V29U9wx1t1CGScFMrHuRVGFdxlj2v4c8vmM7d+biM3oc+Kw7Lq8yzm+yiIqs
	 eFAh6kuOWJGg0NMkTUzifi6Zu1AMGX+FNktEgjEkXuspXK7/cmaE3sWNM2NKmz+a2I
	 gr/fNcYmBcsKe7CaNGxnZrrPdWamXCLiQ65CzbnMrcFxFiy5jIiGrC0uGIZ0aCzgFw
	 DF8QId18IZHbva+hvvUSDVivUGP7ZOulcEqTioEvlloRk6ucVy1yeV+2W+4nhhf4vl
	 UwBVlUMg8AxbA==
From: Jakub Kicinski <kuba@kernel.org>
To: jensemil.schulzostergaard@microchip.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	woojung.huh@microchip.com,
	linux@armlinux.org.uk,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 7/9] net: dsa: lan9645x: add mac table integration
Date: Tue,  5 May 2026 18:46:14 -0700
Message-ID: <20260506014614.1616825-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430-dsa_lan9645x_switch_driver_base-v4-7-f1b6005fa8b7@microchip.com>
References: <20260430-dsa_lan9645x_switch_driver_base-v4-7-f1b6005fa8b7@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0C2F54D565F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-284656-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: lan9645x: add mac table integration

This patch adds MAC table support and hooks it into the DSA FDB callbacks
(port_fdb_add, port_fdb_del, port_fdb_dump, port_fast_age), along with a
port-filtered flush path and a GET_NEXT-based dump helper.

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c
> new file mode 100644
> index 000000000000..7ae23d3464f8
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c

[ ... ]

> +void lan9645x_mac_init(struct lan9645x *lan9645x)
> +{
> +	u32 val;
> +
> +	mutex_init(&lan9645x->mact_lock);
> +
> +	/* Clear the MAC table */
> +	lan_wr(ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_INIT),
> +	       lan9645x, ANA_MACACCESS);
> +
> +	if (lan9645x_rd_poll_timeout(lan9645x, ANA_MACACCESS, val,
> +				     ANA_MACACCESS_MAC_TABLE_CMD_GET(val) ==
> +				     CMD_IDLE))
> +		dev_err(lan9645x->dev, "mac init timeout\n");
> +}

Should lan9645x_mac_init() propagate the CMD_INIT timeout instead of
logging and returning?

It is declared void and the only timeout handling is a dev_err().  The
caller in lan9645x_setup() invokes it without a return value and then
proceeds to configure flooding PGIDs, per-port CPU forwarding, and
register the dsa_switch_ops callbacks (.port_fdb_add, .port_fdb_del,
.port_fast_age, .port_fdb_dump) while the MAC table command engine may
still be busy.

For comparison, lan9645x_vlan_init() (called just above in setup) treats
the structurally identical clear-table timeout as fatal:

	lan_wr(ANA_VLANACCESS_VLAN_TBL_CMD_SET(VLANACCESS_CMD_INIT),
	       lan9645x, ANA_VLANACCESS);

	err = lan9645x_vlan_wait_for_completion(lan9645x);
	if (err) {
		dev_err(lan9645x->dev, "Vlan clear table failed\n");
		return err;
	}

Would returning an int from lan9645x_mac_init() and checking it in
lan9645x_setup() be more consistent?

[ ... ]

> +int lan9645x_mact_dsa_dump(struct lan9645x *lan9645x, int port,
> +			   dsa_fdb_dump_cb_t *cb, void *data)
> +{
> +	u8 mac[ETH_ALEN] __aligned(2);
> +	u32 mach, macl, maca;
> +	int err = 0;
> +	u32 autoage;
> +	u64 addr;
> +	u16 vid;
> +	u8 type;

[ ... ]

> +		type = ANA_MACACCESS_ENTRYTYPE_GET(maca);
> +		mach = lan_rd(lan9645x, ANA_MACHDATA);
> +		macl = lan_rd(lan9645x, ANA_MACLDATA);
> +
> +		if (ANA_MACACCESS_DEST_IDX_GET(maca) == port &&
> +		    type == ENTRYTYPE_NORMAL) {
> +			addr = (u64)ANA_MACHDATA_MACHDATA_GET(mach) << 32 |
> +			       macl;
> +			u64_to_ether_addr(addr, mac);
> +			vid = ANA_MACHDATA_VID_GET(mach);
> +			if (vid > VLAN_MAX)
> +				vid = 0;
> +
> +			err = cb(mac, vid, false, data);
> +			if (err)
> +				break;
> +		}
> +	}

Does this filter cause user-added FDB entries to be invisible to
'bridge fdb show'?

lan9645x_fdb_add() unconditionally programs entries as ENTRYTYPE_LOCKED:

	return lan9645x_mact_learn(lan9645x, dest, addr, vid, ENTRYTYPE_LOCKED);

but the dump above only reports entries matching ENTRYTYPE_NORMAL, so any
entry installed via 'bridge fdb add dev swpN <mac> self [static]' is
present in hardware and not reported through port_fdb_dump.

For NTF_SELF entries the DSA core path
(net/dsa/user.c:dsa_user_port_fdb_do_dump) depends on port_fdb_dump to
surface entries that are not tracked in the bridge software FDB.

Separately, the callback hardcodes is_static=false for every reported
entry:

	err = cb(mac, vid, false, data);

If the ENTRYTYPE_LOCKED filter is relaxed, would is_static need to be
derived from the entry type, similar to ocelot_fdb_dump() in
drivers/net/ethernet/mscc/ocelot.c which uses
(entry.type == ENTRYTYPE_LOCKED)?

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> index c99189ce586e..b21e1bf25b0c 100644
> --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> @@ -139,6 +140,7 @@ static int lan9645x_setup(struct dsa_switch *ds)
>  	err = lan9645x_vlan_init(lan9645x);
>  	if (err)
>  		return err;
> +	lan9645x_mac_init(lan9645x);

Related to the lan9645x_mac_init() comment above, should this call
check a return value and abort setup on failure rather than continuing
to register switch ops with a potentially wedged MAC table engine?

[ ... ]

> +static int lan9645x_fdb_add(struct dsa_switch *ds, int port,
> +			    const unsigned char *addr, u16 vid,
> +			    struct dsa_db db)
> +{
> +	struct net_device *br = lan9645x_db2bridge(db);
> +	struct dsa_port *dp = dsa_to_port(ds, port);
> +	struct lan9645x *lan9645x = ds->priv;
> +	int dest;
> +
> +	if (IS_ERR(br))
> +		return PTR_ERR(br);
> +
> +	if (dsa_port_is_cpu(dp) && !br &&
> +	    dsa_fdb_present_in_other_db(ds, port, addr, vid, db))
> +		return 0;
> +
> +	if (!vid)
> +		vid = lan9645x_vlan_unaware_pvid(!!br);
> +
> +	dest = dsa_port_is_cpu(dp) ? PGID_CPU : port;
> +
> +	return lan9645x_mact_learn(lan9645x, dest, addr, vid, ENTRYTYPE_LOCKED);
> +}

See the question above about lan9645x_mact_dsa_dump() filtering on
ENTRYTYPE_NORMAL: entries created here with ENTRYTYPE_LOCKED do not
appear to be reported by port_fdb_dump.

