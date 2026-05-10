Return-Path: <netdev+bounces-286357-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBxsFt7BAGqJMQEAu9opvQ
	(envelope-from <netdev+bounces-286357-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:35:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B53B5505736
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3B9E3020AB8
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BD73B4EA7;
	Sun, 10 May 2026 17:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtERPrhx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357473B47E9;
	Sun, 10 May 2026 17:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778434489; cv=none; b=V3GHLE+5y4s0K9lwdQp8rBtiHZYekNnL4UizJA2e+qbLjzlYnJWBGUzrRhlXfBkWr8zSC8fCCc2MpdLNK7LA9Mu/PeIMNKFHmfGgxKxcJxbEpnxkUJL/jUcviv3+R3ixO8IiNs0HcWVTkscn9miLrIZ49MxuCV1EWJDI0gmjBrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778434489; c=relaxed/simple;
	bh=PDi7yEN3GT36nazloQTh5Qk6WtKH6FP8/AQGrR3aaKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRta9rrGAFkf9PY31Q99BVbKoIjsS/imfb78e60al0broB8QPqnwcWMnX/mXo4LZspQY9nY4uenuO7734zfjAKn4y8OP+ixOTWXQpBDtbAj4upl5LtaL58M9WdefY5v6Gy3J9y8QiVoJaL+7MYICfKqYPYtG3VeJZtCMd4pkOQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtERPrhx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C33BC2BCB8;
	Sun, 10 May 2026 17:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778434489;
	bh=PDi7yEN3GT36nazloQTh5Qk6WtKH6FP8/AQGrR3aaKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DtERPrhxB2zgbfNa1vKeY8ZVmNO3/4tBG72a/mJM15gYy1DgxOMO1Wg3JFeoXns30
	 LqCCGArL5ou2+1wznYw1keLe2W2AVU6V7e9dMgZAh9amhhdj5forzhyLcwye5Ys6Ah
	 afUwEpAImMPOfHLJHla/t3cIiMHn+pVuO8gBIrLShmXoOUGmsxlojRLbpHFpp0fX+c
	 S5wH1nX9Sqvo7Tq0K0p/fLuA2M1mI2quuqpSe25t5Tes5KxGh3y46OpwSBPGv+yCny
	 4HhihouzLOJdCpFyN1YGPtP8Q0EDgbhbUV34s6eAtVsYPQJoWYcEw1E05d/38nBcXf
	 UcKV/2CveoMoA==
From: Jakub Kicinski <kuba@kernel.org>
To: luizluca@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linusw@kernel.org,
	alsi@bang-olufsen.dk,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v3 4/8] net: dsa: realtek: rtl8365mb: add table lookup interface
Date: Sun, 10 May 2026 10:34:47 -0700
Message-ID: <20260510173447.3919830-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506-realtek_forward-v3-4-1d87c5f85a3b@gmail.com>
References: <20260506-realtek_forward-v3-4-1d87c5f85a3b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B53B5505736
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286357-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: realtek: rtl8365mb: add table lookup interface

This commit adds a generic table lookup interface for the RTL8365MB switch
family via rtl8365mb_table_query(), centralizing access to the internal
ACL, CVLAN, L2 and IGMP tables behind a single helper.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_table.c b/drivers/net/dsa/realtek/rtl8365mb_table.c
> new file mode 100644
> index 000000000000..df312769b0be
> --- /dev/null
> +++ b/drivers/net/dsa/realtek/rtl8365mb_table.c

[ ... ]

> +int rtl8365mb_table_query(struct realtek_priv *priv,
> +			  enum rtl8365mb_table table,
> +			  enum rtl8365mb_table_op op, u16 *addr,
> +			  enum rtl8365mb_table_l2_method method,
> +			  u16 port, u16 *data, size_t size)
> +{
> +	bool addr_as_input = true;
> +	bool write_data = false;
> +	int ret = 0;
> +	u32 cmd;
> +	u32 val;
> +	u32 hit;
> +
> +	/* Prepare target table and operation (read or write) */

[Medium]
Is the size argument validated anywhere in this function?  The kerneldoc
for rtl8365mb_table_query() in rtl8365mb_table.h states:

    * @size must match the size of the target table entry, expressed in 16-bit
    * words. This function only validates that it is non-zero and fits in the
    * available register space.

but no check of the form

    if (!size || size > RTL8365MB_TABLE_ENTRY_MAX_SIZE)
            return -EINVAL;

appears to exist.  All in-tree callers introduced by subsequent patches
pass compile-time-constant sizes well within bounds, so nothing breaks
today, but should the kerneldoc be adjusted to make the caller
responsible, or should the validation it promises be added at the top of
the function?

[ ... ]

> +	/* Write entry data if writing to the table (or L2_METHOD_MAC) */
> +	if (write_data) {
> +		/* bulk write data up to 9th byte */
> +		ret = regmap_bulk_write(priv->map_nolock,
> +					RTL8365MB_TABLE_WRITE_BASE,
> +					data,
> +					min_t(size_t, size,
> +					      RTL8365MB_TABLE_ENTRY_MAX_SIZE -
> +						      1));

[Low]
Does the comment "bulk write data up to 9th byte" match the code?  The
data parameter is declared as u16 *, the kerneldoc defines @size as
"size of @data in 16-bit words", and regmap_bulk_write() counts in
register-sized units (2 bytes here).  The min_t() clamp of
RTL8365MB_TABLE_ENTRY_MAX_SIZE - 1 is 9 words (18 bytes), not 9 bytes.

> +		if (ret)
> +			goto out;
> +
> +		/* 10th register uses only 4 less significant bits */

[Low]
Should "4 less significant bits" read "4 least significant bits" here?
RTL8365MB_TABLE_10TH_DATA_MASK is GENMASK(3, 0), i.e. the four least
significant bits.

> +		if (size == RTL8365MB_TABLE_ENTRY_MAX_SIZE) {
> +			val = FIELD_PREP(RTL8365MB_TABLE_10TH_DATA_MASK,
> +					 data[size - 1]);
> +			ret = regmap_update_bits(priv->map_nolock,
> +						 RTL8365MB_TABLE_WRITE_10TH_REG,
> +						 RTL8365MB_TABLE_10TH_DATA_MASK,
> +						 val);
> +		}
> +
> +		if (ret)
> +			goto out;
> +	}

[ ... ]

> +	/* Finally, get the table entry if we were reading */
> +	if (op == RTL8365MB_TABLE_OP_READ) {
> +		ret = regmap_bulk_read(priv->map_nolock,
> +				       RTL8365MB_TABLE_READ_BASE,
> +				       data, size);
> +
> +		/* For the biggest table entries, the uppermost table
> +		 * entry register has space for only one nibble. Mask
> +		 * out the remainder bits. Empirically I saw nothing
> +		 * wrong with omitting this mask, but it may prevent
> +		 * unwanted behaviour. FYI.
> +		 */
> +		if (size == RTL8365MB_TABLE_ENTRY_MAX_SIZE) {
> +			val = FIELD_GET(RTL8365MB_TABLE_10TH_DATA_MASK,
> +					data[size - 1]);
> +			data[size - 1] = val;
> +		}
> +	}

[Low, Medium]
Should the return value of regmap_bulk_read() be checked before falling
through to the data[size - 1] masking block?  Every other regmap call in
this function bails out with "if (ret) goto out;".  The ret is still
propagated to the caller via the out: label and the kerneldoc notes that
@data is undefined on error, so there is no functional bug with the
current callers, but the asymmetry stands out.

Relatedly, since size is not validated up front, regmap_bulk_read() is
called with the raw size here while the write path used
min_t(size_t, size, RTL8365MB_TABLE_ENTRY_MAX_SIZE - 1).  If a future
caller passed size > RTL8365MB_TABLE_ENTRY_MAX_SIZE, reads would spill
past the RTL8365MB_TABLE_READ_BASE register window and into whatever
follows, and could write past the caller's buffer too.  Would an
explicit bounds check make the contract enforceable?

> +
> +out:
> +	mutex_unlock(&priv->map_lock);
> +
> +	return ret;
> +}

