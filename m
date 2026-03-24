Return-Path: <netdev+bounces-271214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPu2M8HSwmmFmgQAu9opvQ
	(envelope-from <netdev+bounces-271214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:06:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C8031A79F
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1E2F300DCFC
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515BA377ECA;
	Tue, 24 Mar 2026 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPy4Pqb3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B17B355F5C;
	Tue, 24 Mar 2026 18:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774375544; cv=none; b=qdzo7xluhRGqxG/UGiTs21SbyYvLNvQ5d2TQr7qMNJKaJION75fEeadypSbOUrT7VEtNGwFZq0Lx0Jqkeo7EEKSb0M6RXFbf/qV/C9jZCjzRBZ9ov19R5EMf/qAvjOYhMqb9HFWOJe5Q/aoGWpDVH9qqXYDQF8o9VQO7zbhnwfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774375544; c=relaxed/simple;
	bh=AU7UC3UCuzPY9ocU9SOB0BaMWIlQGomG0q9JxYRB0/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUwvw46Oef0LKh53Ull8j4tuzwedh74LU+tjqtNKIg0QVybiobO6zeHkJeMdlhvPyTbeHF2ku9hO4faiX9gN1DM0KMxiUXijXg8Hg4NPUodIDCtx8KhRQxtAl+LzeLIefthFRi0tmOynYuOUNhy6D55sgJlxbqyl6zAo3/d0gtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPy4Pqb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A828EC19424;
	Tue, 24 Mar 2026 18:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774375543;
	bh=AU7UC3UCuzPY9ocU9SOB0BaMWIlQGomG0q9JxYRB0/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qPy4Pqb3gM0EEDNRzsSp9FtHw3/xCNLqg3ecnTOASDJXddGQPj8QLlgFncvLNoh8B
	 sBIIklUijyYY7Jd7lUOP7Ix7AB6VCNS+65TuTepMPFqIrqYCAQWD4vm7NGJieGT5te
	 GLNEBo1K3xHzJuzRBur094YGhz+5kYrtCkzxROIzTzDTKxkkPdz7+mbywvsGCZNj1j
	 xVIl1HlNGkDP55vwikSc5n7R70WLKpeUJvPEgyFHynEkTkhVo/2YZ7tJfOyB5zFllz
	 H8UHOCRtes2s6+RE7P5QLF08QD5MstfCodorjipenSE8u7WmuY9AJGo+xUd8PrARsq
	 TlMqDK3bVSAwA==
From: Simon Horman <horms@kernel.org>
To: hsu.chih.kai@realtek.com
Cc: Simon Horman <horms@kernel.org>,
	nic_swsd@realtek.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@mork.no,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	davem@davemloft.net
Subject: Re: [PATCH net-next v3 1/2] r8152: add helper functions for PLA/USB OCP registers
Date: Tue, 24 Mar 2026 18:05:32 +0000
Message-ID: <20260324180532.261099-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323082226.2601-451-nic_swsd@realtek.com>
References: <20260323082226.2601-451-nic_swsd@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271214-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 74C8031A79F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
r8152: add helper functions for PLA/USB OCP registers

This commit introduces new helper functions (ocp_dword_w0w1,
ocp_word_w0w1, ocp_byte_w0w1, and their _clr_bits/_set_bits variants)
to simplify bitwise operations on PLA/USB OCP registers throughout the
r8152 driver.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 3b6d4252d34c..ba6dc4dbfd80 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> @@ -3875,35 +3873,30 @@ static void r8153c_ups_en(struct r8152 *tp, bool enable)
>
>  static void r8156_ups_en(struct r8152 *tp, bool enable)
>  {
> -	u32 ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_POWER_CUT);
> -
>  	if (enable) {
>  		r8156_ups_flags(tp);
>
> -		ocp_data |= UPS_EN | USP_PREWAKE | PHASE2_EN;
> -		ocp_write_byte(tp, MCU_TYPE_USB, USB_POWER_CUT, ocp_data);
> +		ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_POWER_CUT,
> +				  UPS_EN | USP_PREWAKE | PHASE2_EN);
>
> -		ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_MISC_2);
> -		ocp_data |= UPS_FORCE_PWR_DOWN;
> -		ocp_write_byte(tp, MCU_TYPE_USB, USB_MISC_2, ocp_data);
> +		ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_MISC_2,
> +				  UPS_FORCE_PWR_DOWN);
>
>  		switch (tp->version) {
>  		case RTL_VER_13:
>  		case RTL_VER_15:
> -			ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_UPHY_XTAL);
> -			ocp_data &= ~OOBS_POLLING;
> -			ocp_write_byte(tp, MCU_TYPE_USB, USB_UPHY_XTAL, ocp_data);
> +			ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_UPHY_XTAL,
> +					  OOBS_POLLING);
                              ^^^^

Does this actually change the hardware behavior for RTL_VER_13 and
RTL_VER_15?

The old code read a 16-bit word with ocp_read_word() to get
OOBS_POLLING (BIT(8)), then cleared BIT(8) in the local variable, but
wrote it back using ocp_write_byte(). Since ocp_write_byte() masks the
data with 0xff, the write operation would only touch the low 8 bits and
never actually clear BIT(8) in the hardware register. This made the old
code effectively a no-op for clearing OOBS_POLLING.

The new code uses ocp_word_clr_bits() which calls ocp_word_w0w1(), and
that performs a proper 16-bit read-modify-write cycle with
ocp_write_word(). This means BIT(8) will now actually be cleared in the
hardware.

While this looks like it fixes a latent bug where OOBS_POLLING was never
being cleared, the commit message describes this as pure refactoring to
simplify the code with no mention of a behavioral change.

Can you confirm whether this behavioral change is intentional? Should
the commit message document that OOBS_POLLING will now actually be
cleared for RTL_VER_13/15 devices during UPS enable, when it was not
being cleared before?

>  			break;
>  		default:
>  			break;
>  		}
>  	} else {
> -		ocp_data &= ~(UPS_EN | USP_PREWAKE);
> -		ocp_write_byte(tp, MCU_TYPE_USB, USB_POWER_CUT, ocp_data);
> +		ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_POWER_CUT,
> +				  UPS_EN | USP_PREWAKE);
>
> -		ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_MISC_2);
> -		ocp_data &= ~UPS_FORCE_PWR_DOWN;
> -		ocp_write_byte(tp, MCU_TYPE_USB, USB_MISC_2, ocp_data);
> +		ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_MISC_2,
> +				  UPS_FORCE_PWR_DOWN);
>
>  		if (ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0) & PCUT_STATUS) {
>  			tp->rtl_ops.hw_phy_cfg(tp);

