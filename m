Return-Path: <netdev+bounces-285099-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLpNJZvp+2nEHwAAu9opvQ
	(envelope-from <netdev+bounces-285099-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 03:23:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 193D54E1EE2
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 03:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 400EA3006B71
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 01:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66916269CE7;
	Thu,  7 May 2026 01:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvQjUZUa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43975261B8D;
	Thu,  7 May 2026 01:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778116993; cv=none; b=IPujwdxOc21XeHAQInTGUpocYSxo2KCbaxAGh+zHqJmxoei5xiybrVxMtR49oEFSfTfQfPYfp1dK91/t92tbO1qIl3nEZIYp6Jg26uKlJEVT1Ay08E/XgZwUCTX7ghTgeePAiXaATPabtbw/XF+IH4N77NWm5OVZTODJGYE00tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778116993; c=relaxed/simple;
	bh=t4slTGJ5CXwEJr/pYqlbOeDgFqg88kjT2d34N1OIWMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iL5rYFB/OTm5G1J/4XkUZ6K0hqVM7vXeBHBJ34PtQOEKpB2jVJPfAj4LFHnLqYfRhv366hvV1Qs2p3ryyYe1vK+Qz1IDFFazwVIlrqMeVDYCePUFfaYmi2jxvZJogcIst/cbKb4vnzF8jzNHetlxNlBX0/JYD/GJOQPZFpR51pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvQjUZUa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AE9C2BCB2;
	Thu,  7 May 2026 01:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778116993;
	bh=t4slTGJ5CXwEJr/pYqlbOeDgFqg88kjT2d34N1OIWMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PvQjUZUaj4Cec1qKEq+agNzMga5z9Rjg7SsFSdczEC/eI5eHWnik5rQKyR8w00X0a
	 z9W7vymTFeMFMYfmDA3GxH26htJiDMEd31YgZJ8yuXJsgg+hcy47Jr9ccM7BZjdYsj
	 xD7u3gdwpNi3oJbqV/vyrqZDLyNmK6AJwFvDzks+91nJcj12rjlPkcjSCDiPvaMYn8
	 skZ3HCiuM8Sl+Ggn8YNiH88NDT2sSay87/VMs87ft5zCw2tuTkuHKuZl3xanN77TJN
	 Qu2H8KZSCLzwBMMQ5bL6nMSoZHKHrNZElDR0PNwkV/n8/G/sM+uKD5JobZkC5Oc6Be
	 S2KwdMXAJrvkg==
From: Jakub Kicinski <kuba@kernel.org>
To: mmyangfl@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: dsa: yt921x: Add port qdisc tbf support
Date: Wed,  6 May 2026 18:23:11 -0700
Message-ID: <20260507012311.2187979-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504101258.1608004-4-mmyangfl@gmail.com>
References: <20260504101258.1608004-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 193D54E1EE2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-285099-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,mojatatu.com,resnulli.us];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: yt921x: Add port qdisc tbf support

This commit wires up the port_setup_tc DSA operation to offload a TBF
qdisc onto the yt921x per-port shaper, adding register definitions for
the shaper control block and a marker-transform helper that shares the
existing policer plumbing.

> diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
> index 42dca9617fb1..dc38e0dd22ee 100644
> --- a/drivers/net/dsa/yt921x.c
> +++ b/drivers/net/dsa/yt921x.c

[ ... ]

> @@ -1378,6 +1390,112 @@ yt921x_dsa_port_policer_add(struct dsa_switch *ds, int port,
>  	return res;
>  }
>  
> +static int
> +yt921x_tbf_validate(struct yt921x_priv *priv,
> +		    const struct tc_tbf_qopt_offload *qopt)
> +{
> +	struct netlink_ext_ack *extack = qopt->extack;
> +
> +	if (qopt->parent != TC_H_ROOT) {
> +		NL_SET_ERR_MSG_MOD(extack, "Parent should be \"root\"");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	switch (qopt->command) {
> +	case TC_TBF_REPLACE: {
> +		const struct tc_tbf_qopt_offload_replace_params *p;
> +
> +		p = &qopt->replace_params;
> +
> +		if (p->mtu || p->peak.rate_bytes_ps) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "Offload not supported when mtu/peakrate is configured");
> +			return -EOPNOTSUPP;
> +		}

Is the p->mtu check overly broad here?  tbf_change() in
net/sched/sch_tbf.c sets q->mtu from the user-supplied qopt->mtu whenever
TCA_TBF_PBURST is absent, so p->mtu can be non-zero even when no peakrate
has been requested.  A user that explicitly passes the mtu parameter to
tc would then be denied offload with an error that attributes the failure
to mtu/peakrate together.

Would gating only on p->peak.rate_bytes_ps better reflect what the
hardware cannot do?

> +
> +		if (!p->rate.mpu) {
> +			NL_SET_ERR_MSG_MOD(extack, "Assuming mpu = 64");
> +		} else if (p->rate.mpu != 64) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "Offload not supported when mpu is other than 64");
> +			return -EOPNOTSUPP;
> +		}

Is setting an extack message on the success path intentional?
psched_ratecfg_precompute() leaves mpu at 0 by default, so the common
tc qdisc add ... tbf rate X burst Y invocation will hit the first branch,
return 0, and iproute2 will then print:

    Warning: yt921x: Assuming mpu = 64.

on every TBF replace.

Also, is the assumption actually enforced anywhere?  yt921x_marker_tfm_shape()
and yt921x_marker_tfm() do not appear to compensate the rate computation
for a 64-byte MPU, so the message seems to document an assumption that is
not modelled by the transform.

> +
> +		break;
> +	}
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}

Would it be clearer to have yt921x_tbf_validate() return -EOPNOTSUPP for
commands the handler cannot service, so the supported command set is
stated once?  The default arm here returns 0 for every command other than
TC_TBF_REPLACE (including TC_TBF_STATS and TC_TBF_GRAFT) while
yt921x_dsa_port_setup_tc_tbf_port() below returns -EOPNOTSUPP for those
same commands.  There is no observable bug today, but if the validator is
ever used on its own the two lists can drift.

> +
> +static int
> +yt921x_dsa_port_setup_tc_tbf_port(struct dsa_switch *ds, int port,
> +				  const struct tc_tbf_qopt_offload *qopt)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	struct netlink_ext_ack *extack = qopt->extack;
> +	u32 ctrls[2];
> +	int res;
> +
> +	switch (qopt->command) {
> +	case TC_TBF_DESTROY:
> +		ctrls[0] = 0;
> +		ctrls[1] = 0;
> +		break;

Is there a concern about the write ordering on teardown?
yt921x_reg64_write() -> yt921x_regs_write() performs two independent
register writes (reg+0 then reg+4).  On TC_TBF_DESTROY the first write
sets CIR=0 and CBS=0 while the previously programmed EN bit in ctrls[1]
is still set; only the second write clears EN.  The REPLACE path writes
configuration before arming EN, but the inverse is not followed here.

Would writing ctrls[1]=0 first (or clearing EN via a read-modify-write
before zeroing CIR/CBS) be safer for the hardware state machine?

> +	case TC_TBF_REPLACE: {
[ ... ]
> +		ctrls[0] = YT921X_PORT_SHAPE_CTRLa_CIR(marker.cir) |
> +			   YT921X_PORT_SHAPE_CTRLa_CBS(marker.cbs);
> +		ctrls[1] = YT921X_PORT_SHAPE_CTRLb_UNIT(marker.unit) |
> +			   YT921X_PORT_SHAPE_CTRLb_EN;
> +		break;
> +	}
> +	default:
> +		return -EOPNOTSUPP;
> +	}

Does returning -EOPNOTSUPP for TC_TBF_STATS defeat the hw offload
indicator?  qdisc_offload_dump_helper() in net/sched/sch_api.c first
clears TCQ_F_OFFLOADED, then calls into the driver, and only re-sets the
flag on a zero return:

    sch->flags &= ~TCQ_F_OFFLOADED;
    if (!tc_skip_hw(sch->flags))
        err = qdisc_offload(sch, type, type_data, extack);
    if (err == -EOPNOTSUPP)
        return 0;
    if (err)
        return err;
    sch->flags |= TCQ_F_OFFLOADED;

tbf_dump() invokes this path on every dump, so even after a successful
TC_TBF_REPLACE, tc -s qdisc show would keep reporting offload false and
tc_fill_qdisc() would emit TCA_HW_OFFLOAD=0.

Would a stub TC_TBF_STATS case that returns 0 (leaving bstats/qstats
untouched) preserve the flag here?  mlxsw does this in its
spectrum_qdisc.c.

[ ... ]

