Return-Path: <netdev+bounces-288847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XWdYMeuXCmpy4AQAu9opvQ
	(envelope-from <netdev+bounces-288847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 06:39:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F11A565B22
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 06:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9059D30078FC
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 04:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA7938237F;
	Mon, 18 May 2026 04:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXO8TjXl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F52D38236A
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 04:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779079143; cv=pass; b=BrbysW+Bp9S2m81fEVnxyYYwAXLGXsnmte8fg1wYOithsoGHpGbRBZTJ9iseQao9MI3bUKz895tZb3KDnh3yYWWVhlUG0WmD19edSeflr0hjipqZD2dfZylJ+9t2tuBof86RPF9SbHbHBB2T3DUv+bHOI3trgnV6nkxEwY6SS1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779079143; c=relaxed/simple;
	bh=0ZIpCNGtOVMqBpNTdiaWcYqX9voy26jlS1rsrj9Vt6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZuNkEz/9BTN7QzWA7nLuuKwoNRU+zCPbQ5FUBioxJA9j5OTgld5Qp2aYUtzDrf6Nx+K6v4JWZELFkwENw6m4OeJvdftDxkG22H5pZRkLkMNwOuUOGxHgD+sx9s/tdLXXZy/EsmH+BrxNEBjqXmi1VUi0iepV9djDCukDzywGqPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXO8TjXl; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67e9b3037dcso3925375a12.0
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 21:39:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779079141; cv=none;
        d=google.com; s=arc-20240605;
        b=LctVrNmp6yXIGDMz61jzmLvmDf7D27vG4saVz8GAEzPro3bAzt63Y8/v+gVw1LW//L
         n2IlYPKDBFj1KRVw1iDxqe4Xq5VlcywYR5L+Ft461IGg8nbcj+xGbur4f8LiAQcdwt0A
         6A4aNIDBvVb44fT+oAZeL3UmkfgD4Bri2IggfdUrV7zAlbGbJITghxiUpBtKR1O+L30D
         FZS9yKmU9OevjPQwttNzdqygcoSeVAT1Ga2vmMZy6HRnHcWNlRUk++T3zFwi6RFFwKmY
         n/4m14gW9jOv3eEFtbjeHfA5V35jFtq9NDzXL11m97uCikdsak+se+d9nsJnt+12l/Yu
         pGQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pXDP9lsvgXDkjBezaqi/L55hhYZzmjnGllvGEmqIFT4=;
        fh=jpZfqOE2rMBZrwY6ZQ01paESzYs3MtEEuWuPjEZfst8=;
        b=i4tF2YVCTO57RoJZfjcodqj+GNW70StDO/1JGa4MZPvKlVjD6kb3RakqCFiWGnq2nC
         ceagZzPo9AIdX5W4/du3aGTRWz6FTeY4Wqs/53DUGE6q3ovtBYfDl06cZ3ZMMkdOdc33
         GjdDGYN2JY768wAAzl8Jwo3pjuuM9k+exOzkgQssGq+CUcXMXxaurjDaFW54cxSAuy7O
         bz8dUGwX3p4kq985bDqqR7nfEFznq+Xik2+i3k+kYYRrKD4fwYyn8+fRb8xJ8m5FJvsy
         Hn4i22si4QJm1AGbfyng/I4q5c7/eXoL3y6vo6XnP+PUt9iopl/nPF6zJrYA8itk+NSM
         TcZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779079141; x=1779683941; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pXDP9lsvgXDkjBezaqi/L55hhYZzmjnGllvGEmqIFT4=;
        b=DXO8TjXllAk+94Udlh0JeJgsHQfFFCgSe4xKq0cQB2zqfBzOmSfg6STDryJEYeQHFL
         Ufo4l4rn+THCdozqjCYYzDK9k/HV7g7v53nf10Ozo2O9w08UFkc07a9+8XXpoyA9Cg3j
         iuDzXwV77u7sky8KsfsP4Ud1qc81JZa+RBROl/pUTx8nkvgecG6rlPA9ldXvxf5+Jp1M
         8gw4nbJ1jCQRIPIKEBe/o49PhS1UmoDYMkZkvelUQgCyyRgxhh6VlzNW13Z6T4zQ9b2m
         OsSDaWrxtjDXy5QQZ6QrKVZC53Qiqvi9WC7mxqPpnRoqB2ky9wAi4ngY3++dFJlHqXym
         xPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779079141; x=1779683941;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXDP9lsvgXDkjBezaqi/L55hhYZzmjnGllvGEmqIFT4=;
        b=Yei4T3Jy1EG9yxVxAzCpRXyzq2SOfB/ECrSGqnPlrcX7VDdPvkTmN2cTFlmu+ZusUA
         Yd78Xr8uySeCmNaKqNI9OC0k/EimXJzrDgVzZP8TQLPrMuCeYgxsoDcpWyCsxwYiyhSR
         V7xvxFYetAIhdVltzRVl4s7OFZlsDp8bLHze7fENREZw7zgfIVjhJaHBFaGQ3f71XM0/
         2iGM9dqJm79BrNOm6raEpSt9gs18XHT0GmKE7t5RN2Rjdw1J3u8G0xxDL47x2NM6LQwL
         9z4NvdlinsPcz3+pmtH7olhN2dRHpz5NpGl3XEBZhrPI8MgnIB7tcDiOtM2A0yhPI2u7
         5IUQ==
X-Gm-Message-State: AOJu0Yw66wkQvlMzWk8K+5h1SLS/i84D6SXN4T9plNn30xTeRAp5qCaR
	9fdK1SWl1usBcRIi9S1SNhsxEuDn8xXCr8ve5TQET1m5Lk1yzjF4F3dob1QqlBafL7q+8rFcM1m
	PJv61/kCOcCRblTLRMcs0QWoXbi0YZ88=
X-Gm-Gg: Acq92OErYwCmgbM5Yg7oL2TPaaYjLZEFBW0JFYFvkNUN1vkbkBQ4YRKJJSp0c+RixrE
	Akz2lscvq+KC1lv5h4zi2vn9LS1NNeegbIh7gFa92Uxcyt7I5IzRnNM51bE6r7bwCh0I8tDtb9a
	py7/E5FxQ201wc0n9lS6gsVkRRqgntvvS93wpJGfPy3UphGVbp/UrBjYIoMewIGuSisYoOTdv5T
	6BWVzfiFUt1eGNB6gomHA6B38CF4c4fQ+bEDxlxQWxu/DWvx0jtWmriGyNqoLzvZnfinVkosbDb
	p28e8fW89S8tCNUe4addQJ+DGzYoSLXbUB3FnxYR
X-Received: by 2002:a05:6402:454e:b0:66a:8002:fe17 with SMTP id
 4fb4d7f45d1cf-683bd0946bcmr5085310a12.13.1779079140422; Sun, 17 May 2026
 21:39:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516-realtek_forward-v4-0-8b6d6a1eefdc@gmail.com> <20260516-realtek_forward-v4-7-8b6d6a1eefdc@gmail.com>
In-Reply-To: <20260516-realtek_forward-v4-7-8b6d6a1eefdc@gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 18 May 2026 01:38:48 -0300
X-Gm-Features: AVHnY4LfPNKKvLSMg9DYA58Z6y0WI4lY7015yrD6Sz3IDTS7awgwRKGhd3GPdJc
Message-ID: <CAJq09z42KH4rrSX+fpyyeNQ8_nPSKcLerkHOyk4WMjWrbvr96w@mail.gmail.com>
Subject: Re: [net-next PATCH v4 7/8] net: dsa: realtek: rtl8365mb: add FDB support
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 1F11A565B22
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288847-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

> +int rtl8365mb_l2_add_mc(struct realtek_priv *priv, int port,
> +                       const unsigned char mac_addr[static ETH_ALEN],
> +                       u16 vid)
> +{
> +       u16 data[RTL8365MB_L2_ENTRY_SIZE] = { 0 };
> +       struct rtl8365mb_l2_mc mc = { 0 };
> +       u16 addr;
> +       int ret;
> +
> +       memcpy(mc.key.mac_addr, mac_addr, ETH_ALEN);
> +       mc.key.vid = vid;
> +       mc.key.ivl = true;
> +       /* Already set the port and is_static, although not used in OP_READ,
> +        * data will be ready for OP_WRITE if it is a new entry.
> +        */
> +       mc.member |= BIT(port);
> +       mc.is_static = 1;
> +       rtl8365mb_l2_mc_to_data(&mc, data);
> +
> +       /* First look for an existing entry (to get existing port members) */
> +       ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
> +                                   RTL8365MB_TABLE_OP_READ, &addr,
> +                                   RTL8365MB_TABLE_L2_METHOD_MAC, 0,
> +                                   data, RTL8365MB_L2_ENTRY_SIZE);
> +       if (!ret) {
> +               /* There is already an entry... */
> +               rtl8365mb_l2_data_to_mc(data, &mc);
> +               dev_dbg(priv->dev, "l2_add_mc: found existing addr=%d member=0x%x igmpidx=0x%x static=%d\n",
> +                       addr, mc.member, mc.igmpidx, mc.is_static);
> +               /* the port must be added as a member */
> +               mc.member |= BIT(port);
> +               rtl8365mb_l2_mc_to_data(&mc, data);

Sashiko asked me to force is_static = 1 on any existing multicast
group. However, I am not sure if the hardware can even create dynamic
multicast groups when operating under a DSA driver. Shouldn't all
multicast control be handled directly by the kernel?

If a dynamic multicast group does appear in the hardware, what would
be the lesser of two evils? I could do as Sashiko suggested and
convert dynamic groups into static ones, but that carries a major risk
of leaking them in the table forever. Alternatively, I could keep them
dynamic and accept losing them once they expire. Personally, I would
prefer to keep the current code as-is.

> +       } else if (ret == -ENOENT) {
> +               /* New entry, no need to update data again as it already
> +                * includes the member.
> +                *
> +                * Multicast hardware entries do not support EFID (bridge
> +                * isolation). However, traffic isolation is still maintained
> +                * because the hardware applies the port isolation masks
> +                * (pmasks) configured in bridge_join after the L2 lookup.
> +                * Entries from different bridges will collide on the same
> +                * MAC+VID slot with an OR'ed member mask, but packets will
> +                * only exit through ports allowed by the source port's pmask.
> +                */
> +       } else {
> +               return ret;
> +       }
> +
> +       /* add the new entry or update an existing one */
> +       ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
> +                                   RTL8365MB_TABLE_OP_WRITE, &addr,
> +                                   0, 0,
> +                                   data, RTL8365MB_L2_ENTRY_SIZE);
> +       /* addr will hold the table index, but it is not used here */
> +       if (ret == -ENOENT) {
> +               /* -ENOENT means the just added entry was not found (and @addr
> +                * does not hold the table index. Although any error will be
> +                * treated equally by the caller, assume that the missing entry
> +                * means the table is full (tested in real HW).
> +                */
> +               return -ENOSPC;
> +       }
> +
> +       return ret;
> +}

> +
> +int rtl8365mb_l2_del_mc(struct realtek_priv *priv, int port,
> +                       const unsigned char mac_addr[static ETH_ALEN],
> +                       u16 vid)
> +{
> +       u16 data[RTL8365MB_L2_ENTRY_SIZE] = { 0 };
> +       struct rtl8365mb_l2_mc mc = { 0 };
> +       u16 addr;
> +       int ret;
> +
> +       memcpy(mc.key.mac_addr, mac_addr, ETH_ALEN);
> +       mc.key.vid = vid;
> +       mc.key.ivl = true;
> +       rtl8365mb_l2_mc_to_data(&mc, data);
> +
> +       /* First look for an existing entry (to get existing port members) */
> +       ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
> +                                   RTL8365MB_TABLE_OP_READ, &addr,
> +                                   RTL8365MB_TABLE_L2_METHOD_MAC, 0,
> +                                   data, RTL8365MB_L2_ENTRY_SIZE);
> +       if (ret == -ENOENT) {
> +               dev_dbg(priv->dev, "l2_del_mc: addr=%d vid=%d missing\n",
> +                       addr, vid);

I will drop addr from the debug message since it will be uninitialized.

> +               /* Silently return success */
> +               return 0;
> +       }
> +
> +       if (ret)
> +               /* Return on any other error */
> +               return ret;
> +
> +       rtl8365mb_l2_data_to_mc(data, &mc);
> +       dev_dbg(priv->dev, "l2_del_mc: found existing addr=%d member=0x%x igmpidx=0x%x static=%d\n",
> +               addr, mc.member, mc.igmpidx, mc.is_static);
> +       /* the port must be removed as a member */
> +       mc.member &= ~BIT(port);
> +       if (!mc.member) {
> +               /* With no members, zero all non-key fields to delete the
> +                * entry. However, setting is_static = 0 might be enough to
> +                * signal the HW to release the slot.
> +                */
> +               mc.is_static = 0;
> +               mc.igmpidx = 0;
> +               mc.priority = 0;
> +               mc.fwd_pri = 0;
> +               mc.igmp_asic = 0;
> +       }
> +       rtl8365mb_l2_mc_to_data(&mc, data);
> +
> +       /* update the existing entry. */
> +       ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
> +                                   RTL8365MB_TABLE_OP_WRITE, &addr,
> +                                   0, 0,
> +                                   data, RTL8365MB_L2_ENTRY_SIZE);
> +       return ret;
> +}

[...]

> @@ -2511,6 +2529,7 @@ const struct realtek_variant rtl8365mb_variant = {
>         .clk_delay = 10,
>         .cmd_read = 0xb9,
>         .cmd_write = 0xb8,
> +       .l2_table_size = RTL8365MB_LEARN_LIMIT_MAX,

Sashiko asked me to reconsider using the learning limit macro to
define .l2_table_size. The vendor's reference code explicitly derives
one definition from the other:

#define RTK_MAX_LUT_ADDR_ID         (RTK_MAX_LUT_ADDRESS - 1)
#define RTK_MAX_LUT_ADDRESS         (RTK_MAX_NUM_OF_LEARN_LIMIT)

To make this relationship explicit and ensure we use each concept
properly, I'll add a new macro:

+/* The LUT table size matches the maximum learning limit */
+#define RTL8365MB_L2_TABLE_SIZE        RTL8365MB_LEARN_LIMIT_MAX

Regards,

Luiz

