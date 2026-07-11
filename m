Return-Path: <netdev+bounces-306878-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +bgRM99hUmp9PAMAu9opvQ
	(envelope-from <netdev+bounces-306878-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 17:31:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 241F0741FE9
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 17:31:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=F8YQJHdq;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306878-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306878-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B90930078EA
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 15:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20B82D9787;
	Sat, 11 Jul 2026 15:30:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9CA26B2AD;
	Sat, 11 Jul 2026 15:30:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783783846; cv=none; b=aimdV+7r4zSz+JBPrar1ZrDK0T5UwnwS2zdaynXWtwQ+j/p6bA3cJWFzythI5qujwYAVsw5sGcIuPUfDujrVJAytIveAPAjw1AbrL9WVfbuONpJ0qYVc2wTWcGi22q4r1NEHLLLl+0K9587GwGd/5CIiBty4Vx7OHht9SKvTXqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783783846; c=relaxed/simple;
	bh=PR7EBeKQX74wOrhYbNbXF4KVKL7eF6oQjRaplZL61us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oiflEfle3pX8uQyU3NBtterdmS8XN4PHDKgVleBWcjbR5oHqwDs/YR4sKQOdX55RDCLFipi4dfE+6s3prPy8i0dtEtzN/ytq+vAwKNOtBFf/wQP4oPppgV+UlnJeBnECFsLePz0+bTzSYyUQc9a1H74xU/a6+LKWSRf7ljEoAFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8YQJHdq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51401F000E9;
	Sat, 11 Jul 2026 15:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783783845;
	bh=1nrlVsmYTDub9fwtb1lUujMqD4oeE7tyke0Ss+01BsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F8YQJHdqApeofr9XQvczgXEhgiVptCuF/usmp9pjRzRgj8CocItT0LgzjUnz/ZIKh
	 RrsPiNuGYyM8iSnfBLcMkZk1ZMaAsoJiyk+snVzqh564pHxAkVIAOJJD4j0q2UpruK
	 LCtfSX8SjEtSDVp70TsD4qKUdInxWFnMyWs8kcPYGVa57GTwsLYNpZbVjGgV2Psb28
	 rN85pzkRlpSfKWDxzSkJhHvf1be455idbGVuHjXNMn5iOcLAMlbB9gFOghx4nr1KZR
	 cda+vbAMhUcMaOKwfOiev2i9EAoh4WiTgguDASp1XEZkDGrS0TZcTuaDdEY6H/Ifyl
	 IlQIefVxnPYiA==
From: Simon Horman <horms@kernel.org>
To: pengpeng@iscas.ac.cn
Cc: Simon Horman <horms@kernel.org>,
	manishc@marvell.com,
	rahulv@marvell.com,
	GR-Linux-NIC-Dev@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netxen: validate unified ROM directory bounds
Date: Sat, 11 Jul 2026 16:30:18 +0100
Message-ID: <20260711153017.1682131-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706093702.81687-1-pengpeng@iscas.ac.cn>
References: <20260706093702.81687-1-pengpeng@iscas.ac.cn>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306878-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:horms@kernel.org,m:manishc@marvell.com,m:rahulv@marvell.com,m:GR-Linux-NIC-Dev@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 241F0741FE9

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
Subject: netxen: validate unified ROM directory bounds

This patch updates the unified ROM parser for the netxen driver to use safer
range validation helpers. It calculates bounds using division and subtraction
to avoid integer overflow vulnerabilities when validating directory entries,
bootloader, firmware, and product tables.

> diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
> index 8bc4e2b69569e..5722c55fa0cce 100644
> --- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
> +++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
[ ... ]
> @@ -561,20 +561,55 @@ int netxen_pinit_from_rom(struct netxen_adapter *adapter)
[ ... ]
> +static struct uni_table_desc *
> +nx_get_table_desc(const u8 *unirom, size_t fw_size, int section)
>  {
>  	struct uni_table_desc *directory = (struct uni_table_desc *) &unirom[0];
> -	__le32 entries = cpu_to_le32(directory->num_entries);
> +	u32 entries = cpu_to_le32(directory->num_entries);
> +	u32 entry_size = cpu_to_le32(directory->entry_size);
> +	u32 findex = cpu_to_le32(directory->findex);
> +	u32 i;
>  
> -	for (i = 0; i < entries; i++) {
> +	if (entry_size < NX_UNI_DIR_ENTRY_MIN_SIZE ||
> +	    !netxen_rom_table_valid(fw_size, findex, entries, entry_size))
> +		return NULL;
>  
> -		__le32 offs = cpu_to_le32(directory->findex) +
> -				(i * cpu_to_le32(directory->entry_size));
> -		__le32 tab_type = cpu_to_le32(*((u32 *)&unirom[offs] + 8));
> +	for (i = 0; i < entries; i++) {
> +		size_t offs = findex + (size_t)i * entry_size;
> +		u32 tab_type = cpu_to_le32(*((u32 *)&unirom[offs] +
> +						NX_UNI_DIR_TYPE_OFF));

[Severity: High]
This isn't a bug introduced by this patch, but can this cast trigger an
unaligned access panic?

If findex or entry_size provided by the firmware header are unaligned,
offs will not be a multiple of 4. Casting &unirom[offs] directly to a
32-bit integer pointer and dereferencing it could fault on architectures that
do not support unaligned memory accesses natively.

>  
>  		if (tab_type == section)
> -			return (struct uni_table_desc *) &unirom[offs];
> +			return (struct uni_table_desc *)&unirom[offs];
>  	}
>  
>  	return NULL;
[ ... ]
> @@ -611,30 +644,30 @@ netxen_nic_validate_bootld(struct netxen_adapter *adapter)
[ ... ]
> -	offs = cpu_to_le32(tab_desc->findex) +
> -		(cpu_to_le32(tab_desc->entry_size) * (idx));
> +	offs = findex + (size_t)entry_size * idx;
>  	descr = (struct uni_data_desc *)&unirom[offs];
> +	data_off = cpu_to_le32(descr->findex);
> +	data_len = cpu_to_le32(descr->size);
>  
> -	data_size = cpu_to_le32(descr->findex) + cpu_to_le32(descr->size);
> -
> -	if (adapter->fw->size < data_size)
> +	if (!netxen_rom_range_valid(adapter->fw->size, data_off, data_len))
>  		return -EINVAL;

[Severity: High]
This is a pre-existing issue, but does netxen_load_firmware() ignore this
validated data_len?

It appears netxen_load_firmware() uses a hardcoded copy size:

netxen_load_firmware() {
    ...
    size = (NETXEN_IMAGE_START - NETXEN_BOOTLD_START) / 8;
    ptr64 = (u64 *)nx_get_bootld_offs(adapter);
    for (i = 0; i < size; i++) {
        data = cpu_to_le64(ptr64[i]);
    ...
}

If data_len is small, couldn't this hardcoded size cause an out-of-bounds slab
memory read past the end of the firmware file data?

>  
>  	return 0;
> @@ -646,29 +679,30 @@ netxen_nic_validate_fw(struct netxen_adapter *adapter)
[ ... ]
> -	offs = cpu_to_le32(tab_desc->findex) +
> -		(cpu_to_le32(tab_desc->entry_size) * (idx));
> +	offs = findex + (size_t)entry_size * idx;
>  	descr = (struct uni_data_desc *)&unirom[offs];
> -	data_size = cpu_to_le32(descr->findex) + cpu_to_le32(descr->size);
> +	data_off = cpu_to_le32(descr->findex);
> +	data_len = cpu_to_le32(descr->size);
>  
> -	if (adapter->fw->size < data_size)
> +	if (!netxen_rom_range_valid(adapter->fw->size, data_off, data_len))
>  		return -EINVAL;

[Severity: High]
This is a pre-existing issue, but does this validation need to enforce a
minimum length for data_len (size)?

In nx_get_fw_version(), the version string pointer calculation relies on size:

nx_get_fw_version() {
    ...
    ver_str = fw->data + cpu_to_le32(fw_data_desc->findex) +
              cpu_to_le32(fw_data_desc->size) - 17;
    for (i = 0; i < 12; i++) {
        if (!strncmp(&ver_str[i], "REV=", 4)) {
    ...
}

If a malformed firmware image provides an entry where size is less than 17,
wouldn't the subtraction wrap around and result in a massive out-of-bounds
memory read?

Additionally, in netxen_load_firmware(), if the firmware data_len is not a
multiple of 8, it seems the remainder is handled unconditionally by reading a
full 8-byte word:

netxen_load_firmware() {
    ...
    size = (__force u32)nx_get_fw_size(adapter) % 8;
    if (size) {
        data = cpu_to_le64(ptr64[i]);
    ...
}

If fw->size is exactly data_off + data_len, wouldn't reading an 8-byte chunk
at an unaligned remainder boundary access up to 7 bytes past the end of the
fw->data buffer?

>  
>  	return 0;
> @@ -682,39 +716,37 @@ netxen_nic_validate_product_offs(struct netxen_adapter *adapter)
[ ... ]
>  nomn:
>  	for (i = 0; i < entries; i++) {
> -
> -		__le32 flags, file_chiprev, offs;
> +		size_t offs;
> +		__le32 flags, file_chiprev;
>  		u8 chiprev = adapter->ahw.revision_id;
>  		uint32_t flagbit;
>  
> -		offs = cpu_to_le32(ptab_descr->findex) +
> -				(i * cpu_to_le32(ptab_descr->entry_size));
> +		offs = findex + (size_t)i * entry_size;
>  		flags = cpu_to_le32(*((int *)&unirom[offs] + NX_UNI_FLAGS_OFF));

[Severity: High]
This isn't a bug introduced by this patch, but can this cast to (int *) also
trigger an unaligned access panic if the firmware supplies an unaligned
findex or entry_size?

>  		file_chiprev = cpu_to_le32(*((int *)&unirom[offs] +
> -							NX_UNI_CHIP_REV_OFF));
> +						    NX_UNI_CHIP_REV_OFF));
>  
>  		flagbit = mn_present ? 1 : 2;
>
-- 
pw-bot: changes-requested

