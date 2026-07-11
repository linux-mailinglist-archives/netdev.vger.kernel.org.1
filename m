Return-Path: <netdev+bounces-306868-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8HwLHJRdUmp1OwMAu9opvQ
	(envelope-from <netdev+bounces-306868-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 17:13:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B33DE741EB1
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 17:13:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Hd1Ngnhh;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306868-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306868-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DABF300EFA0
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 15:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE18B2DB78C;
	Sat, 11 Jul 2026 15:13:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637D64C6D;
	Sat, 11 Jul 2026 15:13:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783782801; cv=none; b=srLQW8Vkf/9UrTOPLMw3ufTmzub8+TEcixlc/J79fUHgwlNKTmnZhaKM3+a8m5WZeMamtEElVNdSUpv6yMScmCPwQ5tBejZ3wUyiBXxHHF/jRq+4vxwktMv19Xf7AGQgUPMhZnDZGbo1bwkn3KX3unJVkMHpQeoYDWu+oLZZ7us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783782801; c=relaxed/simple;
	bh=R38Xb2l6zfJb7ZpyPilbsuO9RtKKuZYV8eTAq+1GYM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHOBAjc1c1kQleNw9/lfMalYcjWHyyNG2NzET857NDHdZxdjNYtWwlbEYf5ioeiOOpnPwiKEyx6cABKMJn0+uHX0weSwppwhi4mFjSQ9JscoRtP04LAV15u76WtjXbp9oboL27E3gerOdScO6jdgZo3uFejmKvitgpzX8pJKXv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hd1Ngnhh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B531F000E9;
	Sat, 11 Jul 2026 15:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783782800;
	bh=Z/a4A7oYLtgOaKoFdchUug3Ikl3xGdfwhU8t5Jw5+PQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hd1NgnhhqWx+4dC0MBuGc8GroE1EldfhxMF4Z7iBnz6Np/AmhJiyr1D4upCONjI3j
	 LKFF19ugBYCYG5oeHpAmyq7h6/OUi1XMcGVV6kdEtfUcPreEf1tqRCvWJ22IAd/g7N
	 7NAecWoTL3WuWJlJ+sTguIyo9jCISKuN9AZ9XuI+fcUdAUaGJnLKfadAKDdQrg6fwp
	 hqfAXVJwHyHGzuhX+IVOQvPNQBfNsZRLFkNelefgQGEZxkuSvAlxIcFS0YgQ+bRUlO
	 ub7kDVJkCj+drzZMVqsPBKeW40Widdu7ImOIScS5W7TlPVcxx2pfcOyeHR7uqL31H7
	 Mg61eN/ubILew==
Date: Sat, 11 Jul 2026 16:13:15 +0100
From: Simon Horman <horms@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Shahed Shaikh <shshaikh@marvell.com>,
	Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: qlcnic: validate unified ROM directory bounds
Message-ID: <20260711151315.GA1364329@horms.kernel.org>
References: <20260706093601.81535-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706093601.81535-1-pengpeng@iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306868-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:shshaikh@marvell.com,m:manishc@marvell.com,m:GR-Linux-NIC-Dev@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:email,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B33DE741EB1

On Mon, Jul 06, 2026 at 05:36:01PM +0800, Pengpeng Hou wrote:
> The unified ROM parser walks directory and data descriptor tables from the
> firmware file. The existing checks compute table and data limits with
> base + count * size or base + size before comparing with the firmware
> size. Those calculations use fields from the firmware image and can wrap
> before the comparison.
> 
> Add range helpers that validate tables and entries with division and
> subtraction instead of overflowing additions. Pass the firmware size into
> the directory lookup helper, validate each directory entry before reading
> its type field, and validate bootloader, firmware and product-table
> entries before their descriptor fields are used.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  .../net/ethernet/qlogic/qlcnic/qlcnic_init.c  | 135 +++++++++++-------
>  1 file changed, 86 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_init.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_init.c
> index 9192c5ad5a16..56620aed804b 100644
> --- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_init.c
> +++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_init.c
> @@ -740,21 +740,55 @@ qlcnic_has_mn(struct qlcnic_adapter *adapter)

...

> +static struct uni_table_desc *qlcnic_get_table_desc(const u8 *unirom,
> +						    size_t fw_size, int section)
>  {
> -	u32 i, entries;
>  	struct uni_table_desc *directory = (struct uni_table_desc *) &unirom[0];
> -	entries = le32_to_cpu(directory->num_entries);
> +	u32 entries = le32_to_cpu(directory->num_entries);
> +	u32 entry_size = le32_to_cpu(directory->entry_size);
> +	u32 findex = le32_to_cpu(directory->findex);
> +	u32 i;

I realise that this isn't the existing style of this code, but where
possible please try to move the arrangement of local variable declarations
to follow reverse xmas tree order - longest line to shortest (seems trivial
in this case). If necessary declarations and split should be split (with
all declarations coming first, then a blank line (probably not necessary
here).

>  
> -	for (i = 0; i < entries; i++) {
> +	if (entry_size < QLCNIC_UNI_DIR_ENTRY_MIN_SIZE ||
> +	    !qlcnic_rom_table_valid(fw_size, findex, entries, entry_size))
> +		return NULL;
>  
> -		u32 offs = le32_to_cpu(directory->findex) +
> -			   i * le32_to_cpu(directory->entry_size);
> -		u32 tab_type = le32_to_cpu(*((__le32 *)&unirom[offs] + 8));
> +	for (i = 0; i < entries; i++) {
> +		size_t offs = findex + (size_t)i * entry_size;

I might have declared i as a size_t to avoid this cast.

> +		u32 tab_type = le32_to_cpu(*((__le32 *)&unirom[offs] +
> +						QLCNIC_UNI_DIR_TYPE_OFF));
>  
>  		if (tab_type == section)
> -			return (struct uni_table_desc *) &unirom[offs];
> +			return (struct uni_table_desc *)&unirom[offs];

It seems that the only change above is an update to white space.
Which is a cleanup separate from the intention of this patch.
Please drop such cleanups from this patch as the add noise.

>  	}
>  
>  	return NULL;

...

> @@ -789,31 +822,33 @@ qlcnic_validate_bootld(struct qlcnic_adapter *adapter)
>  {
>  	struct uni_table_desc *tab_desc;
>  	struct uni_data_desc *descr;
> -	u32 offs, tab_size, data_size, idx;
>  	const u8 *unirom = adapter->fw->data;
> +	size_t offs;
> +	u32 data_len, data_off, entry_size, findex, idx;
>  	__le32 temp;
>  
>  	temp = *((__le32 *)&unirom[adapter->file_prd_off] +
>  		 QLCNIC_UNI_BOOTLD_IDX_OFF);
>  	idx = le32_to_cpu(temp);
> -	tab_desc = qlcnic_get_table_desc(unirom, QLCNIC_UNI_DIR_SECT_BOOTLD);
> +	tab_desc = qlcnic_get_table_desc(unirom, adapter->fw->size,
> +					 QLCNIC_UNI_DIR_SECT_BOOTLD);
>  
>  	if (!tab_desc)
>  		return -EINVAL;
>  
> -	tab_size = le32_to_cpu(tab_desc->findex) +
> -		   le32_to_cpu(tab_desc->entry_size) * (idx + 1);
> -
> -	if (adapter->fw->size < tab_size)
> +	entry_size = le32_to_cpu(tab_desc->entry_size);
> +	findex = le32_to_cpu(tab_desc->findex);
> +	if (entry_size < sizeof(*descr) ||
> +	    !qlcnic_rom_entry_valid(adapter->fw->size, findex, entry_size,
> +				     idx))
>  		return -EINVAL;
>  
> -	offs = le32_to_cpu(tab_desc->findex) +
> -	       le32_to_cpu(tab_desc->entry_size) * idx;
> +	offs = findex + (size_t)entry_size * idx;
>  	descr = (struct uni_data_desc *)&unirom[offs];
> +	data_off = le32_to_cpu(descr->findex);
> +	data_len = le32_to_cpu(descr->size);
>  
> -	data_size = le32_to_cpu(descr->findex) + le32_to_cpu(descr->size);
> -
> -	if (adapter->fw->size < data_size)
> +	if (!qlcnic_rom_range_valid(adapter->fw->size, data_off, data_len))
>  		return -EINVAL;

This is one of two issues flagged by AI-generated of this patch at
sashiko.dev that I plan to include in this email. There are other issues,
which you may wish to look into in the context of possible follow-up. But I
feel that these two warrant consideration in the context of this patch as
they are closely related to it's intent.

  This is a pre-existing issue, but does this validation need to enforce a
  minimum length for the bootloader section?
  The firmware loader unconditionally calculates a hardcoded size for the
  bootloader section and iteratively reads this amount:
  qlcnic_load_firmware() {
      ...
      size = (QLCNIC_IMAGE_START - QLCNIC_BOOTLD_START) / 8;
      ...
      for (i = 0; i < size; i++) {
          data = le64_to_cpu(ptr64[i]);
      ...
  }
  If an attacker provides a firmware image with a valid offset near the end
  of the file and a small declared size, couldn't the loop in
  qlcnic_load_firmware() read past the end of the adapter->fw->data buffer?

>  
>  	return 0;
> @@ -825,29 +860,31 @@ qlcnic_validate_fw(struct qlcnic_adapter *adapter)
>  	struct uni_table_desc *tab_desc;
>  	struct uni_data_desc *descr;
>  	const u8 *unirom = adapter->fw->data;
> -	u32 offs, tab_size, data_size, idx;
> +	size_t offs;
> +	u32 data_len, data_off, entry_size, findex, idx;
>  	__le32 temp;
>  
>  	temp = *((__le32 *)&unirom[adapter->file_prd_off] +
>  		 QLCNIC_UNI_FIRMWARE_IDX_OFF);
>  	idx = le32_to_cpu(temp);
> -	tab_desc = qlcnic_get_table_desc(unirom, QLCNIC_UNI_DIR_SECT_FW);
> +	tab_desc = qlcnic_get_table_desc(unirom, adapter->fw->size,
> +					 QLCNIC_UNI_DIR_SECT_FW);
>  
>  	if (!tab_desc)
>  		return -EINVAL;
>  
> -	tab_size = le32_to_cpu(tab_desc->findex) +
> -		   le32_to_cpu(tab_desc->entry_size) * (idx + 1);
> -
> -	if (adapter->fw->size < tab_size)
> +	entry_size = le32_to_cpu(tab_desc->entry_size);
> +	findex = le32_to_cpu(tab_desc->findex);
> +	if (entry_size < sizeof(*descr) ||
> +	    !qlcnic_rom_entry_valid(adapter->fw->size, findex, entry_size,
> +				     idx))
>  		return -EINVAL;
>  
> -	offs = le32_to_cpu(tab_desc->findex) +
> -	       le32_to_cpu(tab_desc->entry_size) * idx;
> +	offs = findex + (size_t)entry_size * idx;
>  	descr = (struct uni_data_desc *)&unirom[offs];
> -	data_size = le32_to_cpu(descr->findex) + le32_to_cpu(descr->size);
> -
> -	if (adapter->fw->size < data_size)
> +	data_off = le32_to_cpu(descr->findex);
> +	data_len = le32_to_cpu(descr->size);
> +	if (!qlcnic_rom_range_valid(adapter->fw->size, data_off, data_len))
>  		return -EINVAL;
>  
>  	return 0;

This is the other portion of the AI-generated review of this patch on
sashiko.dev that I'd like to as you to consider in the context of this patch.

  This is a pre-existing issue, but does this validation need to verify that
  data_len is at least 17 bytes?
  In qlcnic_get_fw_version(), the version string pointer is calculated like
  this:
  qlcnic_get_fw_version() {
      ...
      ver_str = fw->data + le32_to_cpu(fw_data_desc->findex) +
                le32_to_cpu(fw_data_desc->size) - 17;
      ...
  }
  If the firmware image specifies a size less than 17, won't
  le32_to_cpu(fw_data_desc->size) - 17 wrap around due to 32-bit unsigned
  arithmetic, leading to an out-of-bounds pointer well outside the fw->data
  buffer?

...

-- 
pw-bot: changes-requested

