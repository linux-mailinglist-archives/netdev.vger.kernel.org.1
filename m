Return-Path: <netdev+bounces-284655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEeZFnGd+mk+QQMAu9opvQ
	(envelope-from <netdev+bounces-284655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:46:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E89C54D5642
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0384D30488FC
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 01:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF652773CA;
	Wed,  6 May 2026 01:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADB+OHg6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26029274B37;
	Wed,  6 May 2026 01:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778031975; cv=none; b=kUNWHVzMvphV/E0VYxfewHhsvia/nPTPVfNSZGVPg5KpDX91wwZzQKYFFkWt4eA7u8ZgEkPtTuHL4ZGDjVfQJnljD2bScDwhjuRHfnykFTkLTmmH2Q5/2OQ01GEC3TVVfIZU3RrYxX6quEIhtdO+L8nS/7zyU2jzvMqRF8BNtzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778031975; c=relaxed/simple;
	bh=lS7Wrq7wdUJ/D4DFGOD9TyRHDxYHCyERHXVhYHPO4TI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEJqqXincQNJxMSbqIeQzyzNwzHpkb74OmSzv79j5Ly1Oyle0Xdi/RLTpc16gb0F9MYZL4PRgiTZvDYk4syv0L4SRkw5FOlhsp5kcCiF7BB3lpYWCw/ZmZuBRcDFvTuKkio8tnupowd9uqWxbI94GGj99O244wZkDbtzuJkqRUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADB+OHg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F311BC2BCB9;
	Wed,  6 May 2026 01:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778031974;
	bh=lS7Wrq7wdUJ/D4DFGOD9TyRHDxYHCyERHXVhYHPO4TI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ADB+OHg6PTBqamzzUcQXxLntdn0bpa1K3vaiLyohPe0jaQWpJ9fBuD2O1RXgsx2Zi
	 ZWoXwcHSovarNb//ZnLIC9tvbUcTHv/yJpsCReMwhA4EA5L3YrWvjyO4D1U7deoPBG
	 U213TK4XCV/VceNXy0rMvWYcQcxBWqwJAoYyW+dBQJcbafB6d30zYapiF5PcND1rJ/
	 ldE0BPKN8ufjqlx3VXd7NDkKTJIhiYAy1oGsJTRDs9/qoXFe59yRQa216t18OMPijp
	 c/us6Y9Ujyl5hroY5ltnZtR5Wtpt2z4ymYxGhwMKEWkj+7Zfqfr2XvOdmdwIy4kQzH
	 QAelQEAmbFYXg==
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
Subject: Re: [PATCH net-next v4 6/9] net: dsa: lan9645x: add vlan support
Date: Tue,  5 May 2026 18:46:11 -0700
Message-ID: <20260506014611.1616806-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430-dsa_lan9645x_switch_driver_base-v4-6-f1b6005fa8b7@microchip.com>
References: <20260430-dsa_lan9645x_switch_driver_base-v4-6-f1b6005fa8b7@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E89C54D5642
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-284655-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: lan9645x: add vlan support

Adds VLAN-aware bridge support to the lan9645x DSA driver, wiring up
.port_vlan_filtering, .port_vlan_add and .port_vlan_del, along with a
new lan9645x_vlan.c that programs the hardware VLAN table and per-port
ingress/egress tag handling. Reserves PVIDs for standalone and unaware
modes to implement FDB isolation.

> net: dsa: lan9645x: add vlan support
>
> Add support for vlanaware bridge. We reserve vid 4095 for standalone
> mode, to implement fdb-isolation. A vlan-unaware bridge uses vid 0.

Does the commit message accurately describe the reserved VID range?
Looking at drivers/net/dsa/microchip/lan9645x/lan9645x_main.h:

    #define UNAWARE_PVID                    0
    #define HOST_PVID                       4095
    #define VLAN_HSR_PRP                    4094
    #define VLAN_MAX                        (VLAN_HSR_PRP - 1)

VLAN_MAX ends up at 4093, and both the add and delete paths reject any
vid > VLAN_MAX, with an extack that says "VLAN range 4094-4095
reserved.". So in practice both 4094 and 4095 are removed from the
user-visible VID space, not only 4095 as the commit log states. Could
the message be updated to reflect that, and to clarify that "A
vlan-unaware bridge uses vid 0" refers to an internal UNAWARE_PVID
rather than to a VID provisioned by the bridge core (the driver
silently returns 0 for vid == 0)?

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c
> new file mode 100644
> index 000000000000..854a2dde1ecf
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c

[ ... ]

> +int lan9645x_vlan_port_add_vlan(struct lan9645x_port *p, u16 vid, bool pvid,
> +				bool untagged, struct netlink_ext_ack *extack)
> +{
> +	struct lan9645x *lan9645x = p->lan9645x;
> +	struct lan9645x_vlan_port_info info;
> +	struct lan9645x_vlan old_vlan;
> +	struct lan9645x_vlan *v;
> +	u16 old_pvid;
> +
> +	/* Kernel VLAN core adds vid 0, which collides with our UNAWARE_PVID.
> +	 * We handle priority tagged frames by other means.
> +	 */
> +	if (!vid)
> +		return 0;
> +
> +	if (vid > VLAN_MAX) {
> +		NL_SET_ERR_MSG_MOD(extack, "VLAN range 4094-4095 reserved.");
> +		return -EBUSY;
> +	}

Is reserving VID 4094 for HSR/PRP appropriate at this point? Grepping
the series shows VLAN_HSR_PRP has no consumer beyond its use in the
definition of VLAN_MAX, and no HSR/PRP code is present in-tree for
this driver.

The net effect is that 4094, a valid 802.1Q VID, is permanently
carved out of the user-visible VLAN space on first merge. Would it be
better to only reserve 4095 now, and introduce the 4094 reservation
together with the HSR/PRP support that actually consumes it?

On the errno choice: -EBUSY conventionally implies a transient
condition that might succeed on retry, but this rejection is
permanent for any VID above VLAN_MAX. Would -EOPNOTSUPP (or -EINVAL,
for a structurally out-of-range VID) be a better fit here, so that
userspace tooling does not interpret the failure as retryable?

> +int lan9645x_vlan_port_del_vlan(struct lan9645x_port *p, u16 vid)
> +{
> +	struct lan9645x *lan9645x = p->lan9645x;
> +	struct lan9645x_vlan *v;
> +
> +	if (!vid)
> +		return 0;
> +
> +	if (vid > VLAN_MAX)
> +		return -EBUSY;

Same question for the delete path: should this be -EOPNOTSUPP (or
similar) rather than -EBUSY for a permanently reserved VID?

