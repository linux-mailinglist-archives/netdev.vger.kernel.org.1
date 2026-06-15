Return-Path: <netdev+bounces-299656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7sNoFQ2NMGpVUQUAu9opvQ
	(envelope-from <netdev+bounces-299656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:38:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A5268A997
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:38:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=V2dYIl0T;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299656-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299656-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD714301D318
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7F733F59A;
	Mon, 15 Jun 2026 23:38:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEDC27FD51;
	Mon, 15 Jun 2026 23:38:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781566728; cv=none; b=K+mykRM+u0mhzG3Bss2r/bSXinxbmBIbQGQF6ot021yWz3UAC/m7Q9YF63GdIOLdyQrEg8RF7ATsSQdFgiC9D1t1g2BFOiBDxiIPjPdE5Jn6oVdjhLEsMhNO3tAHKx4elXAfOWVyZBKlR7H8PZYJgpScjsnJTCpmzK1e4exCOCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781566728; c=relaxed/simple;
	bh=EHkcbtlSNZKJhIiEYkEZCMaufKHX5RySd5AcRkTzRSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kHO1Um9Ci9YsslFRFA/VSkp87fVM4ngXBtOPUP48oOoBiIuoyiJ+oIJU0FLO8lR4h2N28NWUzQJ3dZp4XF0ipuaSbusAzKZ0a3gq3f0adCjOYm7Wf0PEQIXeQ7vjVJ6V9Mear7jIa6ExPjhBayeXOi9SlCiyg2E3QZWGEhyNovQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2dYIl0T; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DB81F000E9;
	Mon, 15 Jun 2026 23:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781566727;
	bh=Xu16QBgKPLOAs6tIPzhjEHQSe0fKVo2Y4Yk32qsOGwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V2dYIl0TZzMlxBl0H6oMbIesaC94xib3XFsWF0LzgMugdVTgX7yRSGzcl6/fvgvPS
	 TptwAomeLEF8/AtTuvGwGl5yG3tM76OUpkq32Fdt2AjgtHSXvR+uKb0MtFjdS/Uu1z
	 bIyxkdja+DpLU0BvsigVKHrjVc4SRxOy1JfEl4ms5KKIkQp9NMzmOe2ili9CdxvF+L
	 Qdqg6TF59AX8Y/2BoRTrP4Vep0RXBSoaSSv2VKoC/0unGupbDyUWN/MX8uUaJj1VQP
	 uLtbVqfMyRTZ4EBLXazOF8HXSQ9WWwQGmC5FI3MUArK5/WUnF5dUquuxvnr4B9+QYv
	 8unWO4UYAHjoA==
From: Jakub Kicinski <kuba@kernel.org>
To: jensemil.schulzostergaard@microchip.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	horatiu.vultur@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	daniel.machon@microchip.com,
	Steen.Hegelund@microchip.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next 1/9] net: microchip: vcap: fix rule move for rules of coprime size
Date: Mon, 15 Jun 2026 16:38:45 -0700
Message-ID: <20260615233845.1042219-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612-sparx5_l3_routing-v1-1-fc3c10160f49@microchip.com>
References: <20260612-sparx5_l3_routing-v1-1-fc3c10160f49@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299656-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jensemil.schulzostergaard@microchip.com,m:kuba@kernel.org,m:horatiu.vultur@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:daniel.machon@microchip.com,m:Steen.Hegelund@microchip.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-hardening@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A5A5268A997

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Subject: net: microchip: vcap: fix rule move for rules of coprime size

This patch addresses a discrepancy in how software and hardware move rule
addresses on insert and delete for the LPM VCAP. It introduces a uniform
offset computation aligned to the least common multiple of all rule sizes
in a block. This ensures that hardware and software representations remain
synchronized and all rules land on correctly aligned addresses.

> diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api.c b/drivers/net/ethernet/microchip/vcap/vcap_api.c
> index 0fdb5e363badc..6946fd7384581 100644
> --- a/drivers/net/ethernet/microchip/vcap/vcap_api.c
> +++ b/drivers/net/ethernet/microchip/vcap/vcap_api.c

[ ... ]

> @@ -2275,8 +2336,7 @@ int vcap_add_rule(struct vcap_rule *rule)
>  		       __func__, __LINE__, ret);
>  		goto out;
>  	}
> -	if (move.count > 0)
> -		vcap_move_rules(ri, &move);
> +	vcap_move_rules(ri, &move);
>  
>  	/* Set the counter to zero */
>  	ret = vcap_write_counter(ri, &ctr);

[Severity: High]
This is a pre-existing issue, but does vcap_add_rule() leak the newly
duplicated rule if operations like vcap_write_counter() or
vcap_write_rule() fail later on?

If a failure occurs, the code takes the goto out path:

vcap_add_rule() {
    ...
    ret = vcap_write_rule(ri);
    if (ret) {
        pr_err("%s:%d: rule write error: %d\n", __func__, __LINE__, ret);
        goto out;
    }
out:
    mutex_unlock(&ri->admin->lock);
    return ret;
}

This seems to exit without reverting the earlier list insertions and
hardware moves.

Could this leave the software and hardware states permanently inconsistent
and leak the newly duplicated rule?

[ ... ]

> @@ -2488,59 +2548,52 @@ int vcap_mod_rule(struct vcap_rule *rule)
>  }
>  EXPORT_SYMBOL_GPL(vcap_mod_rule);

[Severity: High]
This isn't a bug introduced by this patch, but does vcap_mod_rule() discard
the active software rule pointer and overwrite hardware with stale addresses?

Looking at vcap_mod_rule(), the function validates the rule using
vcap_get_locked_rule() but ignores the returned pointer:

vcap_mod_rule(struct vcap_rule *rule) {
    struct vcap_rule_internal *ri = to_intrule(rule);
    ...
    if (!vcap_get_locked_rule(ri->vctrl, ri->data.id))
        return -ENOENT;
    ...
    err = vcap_encode_rule(ri);
    if (err)
        goto out;

    err = vcap_write_rule(ri);
}

Because the function continues to use the caller provided copy ri, it
doesn't see updates to the real rule in the admin->rules list.

If the real rule's hardware address was previously shifted due to insertions
or deletions, could writing to the stale address in ri->addr corrupt other
rules in the hardware VCAP?

[ ... ]

One other pre-existing issue noticed while reviewing this subsystem:

[Severity: High]
This is a pre-existing issue, but is it safe to iterate over the admin->rules
list across different VCAP instances without acquiring admin->lock for
each instance?

In vcap_rule_exists():

static bool vcap_rule_exists(struct vcap_control *vctrl, u32 id) {
    ...
    list_for_each_entry(admin, &vctrl->list, list)
        list_for_each_entry(ri, &admin->rules, list)
            if (ri->data.id == id)
                return true;
    return false;
}

If another thread is concurrently inserting or deleting a rule on another
VCAP instance while holding that instance's lock, could this unprotected
concurrent access encounter a data race and dereference a poisoned pointer?
-- 
pw-bot: cr

