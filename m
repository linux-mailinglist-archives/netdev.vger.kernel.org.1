Return-Path: <netdev+bounces-252202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eE+7J0WmcWmjKwAAu9opvQ
	(envelope-from <netdev+bounces-252202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:23:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CF761B29
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B423435A43C
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D403590A6;
	Thu, 22 Jan 2026 04:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hG5EyAxK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2CF2877DA;
	Thu, 22 Jan 2026 04:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769055492; cv=none; b=hcG5YLwQFwVLNWDf+eUEyf/85x1VSEs8uc1nBgMCZVDA+XHYglzQOAYtm6FVVhZGKzhWijDSJ58V9/clghq7RK6RJjn355id93m5daeAx3RWMXx3ES39SXF1kra/LDrx+6lIFUiwLiHOS+1yHvkcPSYqy/VBs85Ehlp/s+Sdbro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769055492; c=relaxed/simple;
	bh=QF/oqk/VBJeqm0uyIqC63VgdRoNVEz0FyvLErWLHLQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e1MPO6KmFcSEk4Xye5JxMF93UPJzRu/xt1e2Q0hVNA5B5Y2s8Pd+lpMhPdRmBYZBm2YcZI7H4GZCtmiSAaBnLDcKGL5+RwYMLV3gJOEYGcaGFG09TdOwJC0PdKyH81q+fOVt/f/7oNKns5szHNqBiV+Czbd+79gPtN+YA7Y9oog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hG5EyAxK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A31C116C6;
	Thu, 22 Jan 2026 04:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769055492;
	bh=QF/oqk/VBJeqm0uyIqC63VgdRoNVEz0FyvLErWLHLQ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hG5EyAxKta8Pg++JQbbvjmVwdPMn56FPGj5XRSFZMs7Qe0sOYAjEH91sImXv2MaSF
	 aZvwltwBuawX760FhITEi0vr1eib7bc2cptggKk9nK1n7ACXhKraqE1HBZuXECG/JJ
	 h8m7CKPAsBleyL0BqGhUPkAlXN2xx9Q/R9ZZ8fwenqP5/87G0+Iarv4V4eDxQ6NqH2
	 eLG1HjBTVix2cBeoZyGgFBL4Y2Lczlp8rfjbzKVtGDN7lXkToORO0iVf36g2FnkzDH
	 uHr5ZJqahR1RoZuFpnejJSFU1TR9xMsz3zc7S5L4inE0JE2WJTEdt0yGu2u37Ajd9d
	 rUPMKwahWu8tA==
Date: Wed, 21 Jan 2026 20:18:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kiran Kella <kiran.kella@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jayakrishnan.udayavarma@broadcom.com,
 ajit.khaparde@broadcom.com, akhilesh.samineni@broadcom.com
Subject: Re: [net-next 2/2] selftests: drv-net: psp: add test for VLAN
 sub-interface
Message-ID: <20260121201810.27d2f970@kernel.org>
In-Reply-To: <20260121073517.3323332-3-kiran.kella@broadcom.com>
References: <20260121073517.3323332-1-kiran.kella@broadcom.com>
	<20260121073517.3323332-3-kiran.kella@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_FROM(0.00)[bounces-252202-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.py:url,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 48CF761B29
X-Rspamd-Action: no action

On Tue, 20 Jan 2026 23:35:17 -0800 Kiran Kella wrote:
> --- a/tools/testing/selftests/drivers/net/psp.py
> +++ b/tools/testing/selftests/drivers/net/psp.py
> @@ -17,7 +17,7 @@ from lib.py import ksft_not_none
>  from lib.py import KsftSkipEx
>  from lib.py import NetDrvEpEnv, PSPFamily, NlError
>  from lib.py import bkg, rand_port, wait_port_listen
> -
> +from lib.py import ip
>  

don't clean up this white space, double new line is a thing in Python
for some reason

>  def _get_outq(s):
>      one = b'\0' * 4
> @@ -568,6 +568,119 @@ def removal_device_bi(cfg):
>      finally:
>          _close_conn(cfg, s)
>  
> +def vlan_basic_send(cfg):
> +    """
> +    Test PSP over VLAN-to-VLAN traffic
> +
> +    Network topology:
> +      Local VLAN (nsim0.100) <---> Remote VLAN (nsim1.100)
> +           |                            |
> +      Local Physical (nsim0) <---> Remote Physical (nsim1)
> +          [PSP configured here]
> +    """
> +    cfg.require_nsim()

why would this only work on nsim?

> +    _init_psp_dev(cfg)
> +
> +    # Store original interface names and addresses
> +    orig_local_ifname = cfg.ifname
> +    orig_local_ifindex = cfg.ifindex
> +    orig_remote_ifname = cfg.remote_ifname
> +    orig_local_addr_v4 = cfg.addr_v["4"]
> +    orig_local_addr_v6 = cfg.addr_v["6"]
> +    orig_remote_addr_v4 = cfg.remote_addr_v["4"]
> +    orig_remote_addr_v6 = cfg.remote_addr_v["6"]

maybe instead of all this saving and restoring just make and object and
give it all the attributes so that it looks like cfg? Instead of
modifying the real cfg I mean.

> +    # VLAN configuration
> +    vlan_id = 100
> +    local_vlan_ifname = f"{orig_local_ifname}.{vlan_id}"
> +    remote_vlan_ifname = f"{orig_remote_ifname}.{vlan_id}"
> +
> +    local_vlan_addr_v4 = "192.0.2.21"
> +    remote_vlan_addr_v4 = "192.0.2.22"
> +    local_vlan_addr_v6 = "2001:db8::21"
> +    remote_vlan_addr_v6 = "2001:db8::22"
> +
> +    try:
> +        # Create VLAN interface on LOCAL side
> +        ip(f"link add link {orig_local_ifname} name {local_vlan_ifname} type vlan id {vlan_id}")

please use defer()

