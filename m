Return-Path: <netdev+bounces-290137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCL3CBBKDmoM9gUAu9opvQ
	(envelope-from <netdev+bounces-290137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:56:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 820D059D00E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BD6630E804D
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 23:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A3A3D47B2;
	Wed, 20 May 2026 23:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9HT/bJf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A373CF660;
	Wed, 20 May 2026 23:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779320678; cv=none; b=CQRSxeIidjlrsp7kikRzZrnnQ+iwa46E9Qbx7/uH+HD2rD3QcIRWsWV6XSDi5SH6+/N3j6LbP3aXOSrFcZy2YTkSPy0xzMpK8YTWju0wbPvkYjPzBzj29HIl50lbIYEbE0TPZr8YKQ0jZ4dL6n9gSFYl5pswHpTMqnYb/dSosuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779320678; c=relaxed/simple;
	bh=HwIC2alwYuWdgGlOeA/qVoiWbsG+N4spNmFrWJvHPVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qM54YqLL1U7oszM/iHQRF6+T91uyoMdH4OuXePWNUANNrl7QebmJ53KeGBc8RHKYHcis6z5Oc81LruecCFUDvVkzHKHXXj/GopGFWooi7RJ9IZx8OEmtct4i7y0ZZ5gcsfsauBn1+F7Jt4mB31pCzdqebx/x/JT2ptulAz+okk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9HT/bJf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C8C1F00A3A;
	Wed, 20 May 2026 23:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779320675;
	bh=uCMDxVYbFvfcqBPccRdbMcaSEn9cwDPuCzWBg6cCzPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e9HT/bJfGVwRzNQMk1D42dkUm4Nm6NZQtUOsMwSw+l9nScAhV7GxwNPPZcBE83v7L
	 fOirl4HL89SBn1oottsqMruaBtTdxjrB1USX7dHU0iDaPoAfJmRrBXCG5HtMQoXe29
	 8wOdhaIrgtFhHBDmmhu5iNlT5AW/Oy5EkozGlDMQna7NEerHhAxanUjSTTYmePvhDq
	 LCs9uznAXTAe92cKCnYEtIwH/DmBhcmOs+S4ypdGzRadD9JhQTfCBT+a/1badFa8w6
	 Q6rEiUZMg7WaSfVjoavvpr+ALqwQgxOK8IbJFiBojGEfTFU1+M0MBJF4sQ/xXhBAqb
	 Xc91srpdKrUlw==
From: Jakub Kicinski <kuba@kernel.org>
To: nikhil.rao@amd.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	brett.creeley@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eric.joyner@amd.com,
	Vamsi.Atluri@amd.com
Subject: Re: [PATCH net-next v2 4/6] pds_core: add PLDM component info display
Date: Wed, 20 May 2026 16:44:34 -0700
Message-ID: <20260520234434.567087-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260516-upstream_v2_clean-v2-4-7e0d66bf4020@amd.com>
References: <20260516-upstream_v2_clean-v2-4-7e0d66bf4020@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290137-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 820D059D00E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
pds_core: add PLDM component info display

This patch extends pdsc_dl_info_get() to report individual PLDM firmware
components (name, version, fixed/running/stored status) via devlink info
when the device identity is version 2 or newer, falling back to the
existing fw_list path otherwise.

> diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
> index 7f44e1a8d4fd..95c3d2531ef1 100644
> --- a/drivers/net/ethernet/amd/pds_core/devlink.c
> +++ b/drivers/net/ethernet/amd/pds_core/devlink.c
> @@ -93,14 +93,78 @@ int pdsc_dl_flash_update(struct devlink *dl,
>  	return pdsc_firmware_update(pdsc, params, extack);
>  }
>  
> +static int pdsc_dl_report_component(struct devlink_info_req *req,
> +				    struct pds_core_fw_component_info *info)
> +{
> +	enum devlink_info_version_type ver_type;
> +	u16 flags = le16_to_cpu(info->flags);
> +	char *ver = info->version;
> +	char buf[32];
> +
> +	ver_type = DEVLINK_INFO_VERSION_TYPE_NONE;
> +	snprintf(buf, sizeof(buf), "fw.%s", info->name);
> +	if (flags & PDS_CORE_FW_COMPONENT_INFO_F_UPDATE_BY_NAME)
> +		ver_type = DEVLINK_INFO_VERSION_TYPE_COMPONENT;
> +
> +	if (flags & PDS_CORE_FW_COMPONENT_INFO_F_FIXED)
> +		return devlink_info_version_fixed_put(req, buf, ver);

[Medium]
Are the FIXED, RUNNING and STARTUP flags meant to be mutually exclusive?

Looking at enum pds_core_component_info_flags, RUNNING, STARTUP, FIXED
and UPDATE_BY_NAME are independent bits. Returning immediately on
F_FIXED short-circuits the subsequent F_RUNNING and F_STARTUP checks,
so a fixed-but-running component (the natural case for goldfw / ROM
firmware that is currently executing) only surfaces as fixed.

The example in the commit message shows fw.goldfw under "running:":

      versions:
        running:
          fw.goldfw 1.2.3
          fw.mainfwa 1.2.4
          fw.mainfwb 1.2.3

If goldfw has F_FIXED|F_RUNNING set, would the early return here cause
the running entry for fw.goldfw to be dropped, contradicting the
example output?

> +
> +	if (flags & PDS_CORE_FW_COMPONENT_INFO_F_RUNNING) {
> +		int err;
> +
> +		err = devlink_info_version_running_put_ext(req, buf,
> +							   ver, ver_type);
> +		if (err)
> +			return err;
> +	}
> +
> +	if (flags & PDS_CORE_FW_COMPONENT_INFO_F_STARTUP)
> +		return devlink_info_version_stored_put_ext(req, buf,
> +							   ver, ver_type);
> +
> +	return 0;
> +}
> +
> +static int pdsc_dl_component_info_get(struct devlink *dl,
> +				      struct devlink_info_req *req,
> +				      struct netlink_ext_ack *extack)
> +{
> +	struct pds_core_component_list_info *list_info;
> +	struct pdsc *pdsc = devlink_priv(dl);
> +	u8 num_components;
> +	int err;
> +	int i;
> +
> +	if (!pdsc->fw_components.num_components) {
> +		err = pdsc_get_component_info(pdsc);
> +		if (err) {
> +			dev_err(pdsc->dev, "Failed to get component_info %pe\n",
> +				ERR_PTR(err));
> +			return err;
> +		}
> +	}

[Medium, Medium]
Two questions about the cache-population logic here.

First, pdsc_get_component_info() handles the ver==0 firmware-incompat
case by emitting a dev_warn and returning 0 without populating
pdsc->fw_components.num_components:

drivers/net/ethernet/amd/pds_core/fw.c:pdsc_get_component_info() {
    ...
    if (comp.get_component_info.ver == 0) {
        dev_warn(pdsc->dev,
                 "Incompatible get_component_info version %u reported by firmware\n",
                 comp.get_component_info.ver);
        err = 0;
        goto out;
    }
    ...
}

The cache-miss guard above checks num_components, which stays zero on
that firmware path. Will every devlink dev info invocation then re-run
the full PDS_CORE_CMD_GET_COMPONENT_INFO devcmd (a 4 KB kzalloc, a
dma_map_single/dma_unmap_single, a synchronous devcmd under
devcmd_lock with timeout devcmd_timeout * 2) and emit a fresh dev_warn
each time?

Second, is there a path that invalidates the cache after a successful
flash? pdsc_dl_flash_update() -> pdsc_firmware_update() ->
pdsc_pldm_firmware_update() / pdsc_legacy_firmware_update() does not
appear to clear pdsc->fw_components.num_components, and
pdsc_get_component_info() populates the info[] array in place. After a
flash, will subsequent devlink dev info calls keep showing the
pre-flash version strings until the driver is reloaded?

> +
> +	list_info = &pdsc->fw_components;
> +	num_components = min_t(u8, list_info->num_components,
> +			       le16_to_cpu(pdsc->dev_ident.max_fw_slots));

[Medium]
Is the type chosen for min_t() here correct?

max_fw_slots is __le16 in struct pds_core_dev_identity, so the wire
protocol allows values up to 65535, and min_t(u8, ...) casts both
operands to u8 before comparing.

For example, with max_fw_slots = 256, le16_to_cpu() yields 256, the
u8 cast turns it into 0, and the loop reports zero components even
when num_components is non-zero. With max_fw_slots = 257 only one
component would be reported, and so on.

Should this be min_t(u32, ...) (or similar wider type), or even just
list_info->num_components, given that pdsc_get_component_info()
already bounds num_components by PDS_CORE_FW_COMPONENT_LIST_LEN, the
actual size of list_info->info[]? Capping by max_fw_slots also seems
to silently drop valid entries when firmware reports more components
than slots.

> +	for (i = 0; i < num_components; i++) {
> +		err = pdsc_dl_report_component(req, &list_info->info[i]);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +

[ ... ]

