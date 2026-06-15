Return-Path: <netdev+bounces-299533-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GaRtLDUoMGq9PAUAu9opvQ
	(envelope-from <netdev+bounces-299533-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:28:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDAE6885E4
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:28:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="E/ZggfeJ";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299533-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299533-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 42636300B9E7
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B5A409139;
	Mon, 15 Jun 2026 16:19:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B03127A133
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 16:19:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540342; cv=none; b=Y4CPWn9xZX72i1omjSMES8UaZHRHMtBJbvXkNaj0oYqF4Fi5KUDE6xtXObQSFZTVlsxF2nbLNTujncBwVcnAA5Iqz/FaxsWRO/GisQSntV8DRRLzT0K9RFth2udGsptqQ3LkkDGwMeJlsMG990k5V+9jgCzbzvBNVhAVd5RqZJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540342; c=relaxed/simple;
	bh=5Uag3zjIxtRvrFUaEFGUBr5db5WRq86PStUEaSYY9AU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNweW6+kA7KqrBws7tUuQt2Y3uuJOzmXOD24wCu//Su+6AwNp3GPxpRK/PxnNHtgsEs9snolQo/kqfp6TYguRzOxiB7M7cV6usYi2WyE7mp6aZVH5/oFiHNNYSqZBsHa+U2xGmcnAAWFzqxm7QEf9ssxQssWohgqhfoqS2kkmVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/ZggfeJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152271F000E9;
	Mon, 15 Jun 2026 16:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781540341;
	bh=rOVwRblq+kXOEfnLr/2rV1WvW/4t23PkkcJBFhDrgBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E/ZggfeJJvFdx5Totz5pb49AIvcH99XwILodHwtTz2iyaL6nKwKOJTAqPorwG0aM5
	 9fD6uLVkmMqIIlTTzi/4LRW2ezxNdKTHChmLctkFmlX6MSbpg3pDpwn8UDZE/RqhEv
	 VwCVw1n+VY1OeAQg2F5QCoqk9Nf8EwcpWz5LAE6XVs4hgfpIghATN+V7JfWyBeKE1+
	 9IKh2oyFk9ilEe0JEAT/pAGQVy3UE2phLLPjf5BJbLs23SlNl0TImwQh5yZKVxBKVv
	 UNXa4tsNBibHk4VvbswkQE7y2riQU567PbnuHujDWRiYDlvhql4lvX7/QjYUIukOVI
	 4DtQudHJ6aoGA==
From: Simon Horman <horms@kernel.org>
To: nikhil.rao@amd.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	brett.creeley@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	eric.joyner@amd.com
Subject: Re: [PATCH v4 4/6] pds_core: add PLDM component info display
Date: Mon, 15 Jun 2026 17:08:45 +0100
Message-ID: <20260615160842.776643-4-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260614050052.1048328-5-nikhil.rao@amd.com>
References: <20260614050052.1048328-5-nikhil.rao@amd.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299533-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nikhil.rao@amd.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:eric.joyner@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,cpld.gold:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,uboot.gold:url,fw.gold:url,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ADDAE6885E4

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/

Simon says: This review seems to be a bit of a mixed bag.
            I've annotated the issues it raises that I'd appreciate
	    you looking over, and the rest, which I don't feel fall
	    in that category.
---
pds_core: add PLDM component info display

This patch reports per-component firmware versions through devlink info on
v2+ devices, replacing the single fw running version with names derived
from the firmware-supplied component list and slot/flag fields.

Simon says: I'm not particularly concerned about the issue raised below -
            I'm forwarding this review because of others raised further down.

[Low]
Before going to the diff, this patch immediately renames user-visible
component names introduced in the immediately preceding commit in the
same series ("pds_core: add PLDM firmware update support via devlink
flash"):

  fw.mainfw      -> fw
  fw.mainfw.gold -> fw.gold

Could these two patches be folded together (or reordered) so the series
introduces the final naming once?  Anyone bisecting between the two
commits would land on the obsolete names.

> diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
> index 3b763ee1715e..2f40b97affd6 100644
> --- a/drivers/net/ethernet/amd/pds_core/devlink.c
> +++ b/drivers/net/ethernet/amd/pds_core/devlink.c
> @@ -93,14 +93,105 @@ int pdsc_dl_flash_update(struct devlink *dl,
>  	return pdsc_firmware_update(pdsc, params, extack);
>  }
>  
> +static int pdsc_dl_report_component(struct devlink_info_req *req,
> +				    struct pds_core_fw_component_info *info)
> +{
> +	enum devlink_info_version_type ver_type;
> +	u16 flags = le16_to_cpu(info->flags);
> +	char *ver = info->version;
> +	const char *name;
> +	char buf[32];
> +
> +	/* Main firmware is reported as generic "fw" */
> +	if (info->component_type == PDS_CORE_FW_TYPE_MAIN) {
> +		if (info->slot_id == PDS_CORE_FW_SLOT_GOLD)
> +			snprintf(buf, sizeof(buf), "fw.gold");
> +		else
> +			snprintf(buf, sizeof(buf), "fw");
> +	} else {
> +		name = pdsc_fw_type_to_name(info->component_type);
> +		if (!name)
> +			return 0;

Simon says: Ditto

[Low]
When firmware reports a component_type that pdsc_fw_type_names[] does
not know about, this returns 0 and silently drops the entry.  Should
this at least dev_warn_once() so a newer firmware advertising a new
component type does not vanish from devlink output without any
operator-visible signal?

> +
> +		if (info->slot_id == PDS_CORE_FW_SLOT_GOLD)
> +			snprintf(buf, sizeof(buf), "fw.%s.gold", name);
> +		else
> +			snprintf(buf, sizeof(buf), "fw.%s", name);
> +	}

Simon says: And this one seems intentional, so I think
            this portion of the review can be ignored.

[Low]
This branch appends ".gold" to any non-MAIN component when slot_id ==
PDS_CORE_FW_SLOT_GOLD, which produces names like fw.bootloader.gold,
fw.uboot.gold and fw.cpld.gold.  The Documentation table updated in
this same patch only lists fw.gold as the stored variant, and the
example output only mentions fw.uboot.gold.

Should the gold suffix be restricted to MAIN, or should the
documentation table be expanded to cover any component_type also
appearing as a .gold variant?

> +
> +	ver_type = DEVLINK_INFO_VERSION_TYPE_NONE;
> +	if (flags & PDS_CORE_FW_COMPONENT_INFO_F_UPDATE_BY_NAME)
> +		ver_type = DEVLINK_INFO_VERSION_TYPE_COMPONENT;
> +
> +	if (flags & PDS_CORE_FW_COMPONENT_INFO_F_FIXED) {

[ ... ]

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

Simon says: ditto

[Medium, Medium]
Two questions about the cache check above.

First, pdsc_get_component_info() has a branch that returns 0 without
populating num_components when firmware reports
comp.get_component_info.ver == 0:

  if (comp.get_component_info.ver == 0) {
          dev_warn_once(pdsc->dev,
                        "Incompatible get_component_info version %u ...\n",
                        comp.get_component_info.ver);
          err = 0;
          goto out;
  }

Since pdsc->fw_components.num_components stays 0 on this path, every
subsequent devlink dev info request re-enters pdsc_get_component_info()
and runs through kmalloc / kzalloc(PDS_PAGE_SIZE) / dma_map_single() /
a full devcmd round-trip with pdsc->devcmd_timeout * 2 under
devcmd_lock / dma_unmap_single().  dev_warn_once() suppresses the
warning after the first hit, so the repetition is invisible.  Should
there be an "unsupported" sentinel that prevents re-querying once v0
firmware is detected?


Simon says: However, the issue flagged below seems to warrant
            investigation in the context of this patch-set.

Second, pdsc->fw_components is only invalidated at the end of
pdsc_firmware_update() ("pdsc->fw_components.num_components = 0;").
If firmware versions change through any other path (FW recovery via
health_work, PCI reset via pci_reset_work, side-channel upgrade) the
cached list stays around and devlink dev info reports stale versions.
Should those reset paths also clear pdsc->fw_components?

> +
> +	list_info = &pdsc->fw_components;
> +	num_components = min_t(u16, list_info->num_components,
> +			       le16_to_cpu(pdsc->dev_ident.max_fw_slots));

Simon says: Likewise, the one below seems to warrant investigation too.

[Medium]
num_components has already been bounded against
PDS_CORE_FW_COMPONENT_LIST_LEN inside pdsc_get_component_info().
max_fw_slots looks like a slot count (gold/main-a/main-b), but the
component list also contains cpld/bootloader/uboot/etc.  If firmware
reports six components on a three-slot device, this min_t() silently
truncates legitimate component entries from the devlink output.

Is this cap intentional, and if so should truncation be logged?  If
not, can the cap simply be dropped?

> +	for (i = 0; i < num_components; i++) {
> +		err = pdsc_dl_report_component(req, &list_info->info[i]);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
>  static char *fw_slotnames[] = {
>  	"fw.goldfw",
>  	"fw.mainfwa",
>  	"fw.mainfwb",
>  };
>  
> -int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
> -		     struct netlink_ext_ack *extack)
> +static int pdsc_dl_fw_list_info_get(struct devlink *dl,
> +				    struct devlink_info_req *req,
> +				    struct netlink_ext_ack *extack)
>  {

[ ... ]

> @@ -134,12 +225,49 @@ int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
>  			return err;
>  	}
>  
> +	return 0;
> +}
> +
> +static int pdsc_dl_info_get_v1(struct devlink *dl,
> +			       struct devlink_info_req *req,
> +			       struct netlink_ext_ack *extack)
> +{
> +	struct pdsc *pdsc = devlink_priv(dl);
> +	int err;
> +
> +	err = pdsc_dl_fw_list_info_get(dl, req, extack);
> +	if (err)
> +		dev_warn_once(pdsc->dev, "Failed to get fw list: %pe\n",
> +			      ERR_PTR(err));

Simon says: Again, the one below seems to warrant investigation.

[Medium]
Pre-patch, devlink_info_version_stored_put() failures inside the fw
list loop returned to the devlink layer immediately.  After this
refactor, pdsc_dl_fw_list_info_get() returns the error but
pdsc_dl_info_get_v1() converts it to dev_warn_once() and continues to
append the running fw version and the ASIC fields.

Does this mean a mid-loop failure (for example -EMSGSIZE from netlink
attribute append) is now masked, leaving a partially populated devlink
info reply that gets reported as success?

> +
> +	/* Version 1: report fw from dev_info (running only) */
>  	err = devlink_info_version_running_put(req,
>  					       DEVLINK_INFO_VERSION_GENERIC_FW,
>  					       pdsc->dev_info.fw_version);
>  	if (err)
>  		return err;
>  
> +	return 0;
> +}
> +
> +int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
> +		     struct netlink_ext_ack *extack)
> +{
> +	struct pdsc *pdsc = devlink_priv(dl);
> +	char buf[32];
> +	int err;
> +
> +	if (pdsc->dev_ident.version >= PDS_CORE_IDENTITY_VERSION_2) {
> +		err = pdsc_dl_component_info_get(dl, req, extack);
> +		if (err)
> +			dev_warn_once(pdsc->dev, "Failed to get component info: %pe\n",
> +				      ERR_PTR(err));
> +	} else {
> +		err = pdsc_dl_info_get_v1(dl, req, extack);
> +		if (err)
> +			return err;
> +	}

Simon says: but this one seems to be more a question of style that substance.

[Medium]
On v2+ devices, errors from pdsc_dl_component_info_get() are swallowed
into dev_warn_once() and the function falls through to the ASIC
fields.  Pre-patch behavior always reported pdsc->dev_info.fw_version
via DEVLINK_INFO_VERSION_GENERIC_FW.

After this change, transient failures inside pdsc_get_component_info()
(DMA mapping failure, -ENOMEM, the -ETIMEDOUT/-EAGAIN deferred-DMA
path, the v0-firmware return-0-without-populating branch, the
num_components > LIST_LEN -ENOMEM branch), or even firmware enumerating
components without setting PDS_CORE_FW_COMPONENT_INFO_F_RUNNING on the
MAIN component, cause devlink dev info to show only asic.id, asic.rev
and the serial number with no firmware version reported at all.

Could the v2 path either retain the unconditional running fw fallback
from dev_info.fw_version, or fall through to pdsc_dl_info_get_v1() on
failure, so devlink info never silently loses the fw running version?

Also, since dev_warn_once() suppresses the warning across the lifetime
of the device, callers cannot tell that the netlink reply is partial:
a partially populated message gets the ASIC fields appended and is
reported as success.

> +
>  	snprintf(buf, sizeof(buf), "0x%x", pdsc->dev_info.asic_type);
>  	err = devlink_info_version_fixed_put(req,
>  					     DEVLINK_INFO_VERSION_GENERIC_ASIC_ID,

