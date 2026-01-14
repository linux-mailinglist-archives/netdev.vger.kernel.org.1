Return-Path: <netdev+bounces-249710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA598D1C468
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 04:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E08773008F54
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 03:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88ECE2D0298;
	Wed, 14 Jan 2026 03:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TupL0S0Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A5527FB21
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 03:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768361906; cv=none; b=rfQQgWGZggS7jU1LZ9ZW1t5FRj8udbhUq/e1czL5A4Uj2UWTdc6XgPgF3ujbXVlpUYVHLDpgKI1T2qmWDOh42Z2DD8lnl4Md1vqbGSaOFZZ4HwG28TyT+66ERlOJBizMVyqhZCq9sCC7bO+dTDczvQnhry9r4zfcgBjG9Ehz9Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768361906; c=relaxed/simple;
	bh=EoRxDB/I9az4pqMN3S0r+AwzFHhpRkBJT4vv8b/VTqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+p0Tcw8ObP3u8dDS+dbNtLY4Cgqy/YFoeZxF9FKh55cKN2hlTetcnrbWe7HqAdtGzYa8tzDBlh5lm22sHVAcZzd8GSESRZeY7wXIPrttgdMtx8o4PaiNhP4Cjpxas97c9YquM3maY/MBE8G79pZhOeuOwYkFT3uDC5sX/gIpII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TupL0S0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B74CC4CEF7;
	Wed, 14 Jan 2026 03:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768361906;
	bh=EoRxDB/I9az4pqMN3S0r+AwzFHhpRkBJT4vv8b/VTqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TupL0S0ZrVAhOiIcTzK4QSIuSfLK9tL6EFu0oSD7hGJtVtxnDLmnoi0neqaWeyHst
	 uJqHr1q63QvHConjUgbe8WIYYFpN1nwNZtIfgX5LAVFBPwxt4d0JDJY9tmA+6b74lg
	 zdzKD6pUAz87ZeGW/N25ZCdwHtC7J/10Gkv5MD3I+IZLzX50DXpX6LzEeFKWPFNQqV
	 6AF/kqel2OVQ05mOHZaJ8d5Xc+oNgpnLhv/omIP9jqjKQOt400PRv6bOq5QwjOUssI
	 04WayQ9WsLSBeinSMeVEk2Vc4rArT5t1NHyI6UJhKjtBU3nf/MAX5886bMtB4ByzmC
	 Y/7Ps3pLeLXwA==
From: Jakub Kicinski <kuba@kernel.org>
To: mohsin.bashr@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	davem@davemloft.net,
	sanman.p211993@gmail.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	alexanderduyck@fb.com,
	kernel-team@meta.com,
	edumazet@google.com,
	lee@trager.us
Subject: Re: [net-next,V0.5,5/5] eth: fbnic: Update RX mbox timeout value
Date: Tue, 13 Jan 2026 19:38:24 -0800
Message-ID: <20260114033824.1033374-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112211925.2551576-6-mohsin.bashr@gmail.com>
References: <20260112211925.2551576-6-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least pausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
eth: fbnic: Update RX mbox timeout value

This commit unifies timeout values for mailbox RX read requests and
introduces a wrapper function fbnic_mbx_wait_for_cmpl() to simplify the
completion wait calls.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
> index 1ecd777aaada..6b3fb163d381 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h

[ ... ]

> +static inline bool fbnic_mbx_wait_for_cmpl(struct fbnic_fw_completion *cmpl)
> +{
> +	return wait_for_completion_timeout(&cmpl->done,
> +					   FBNIC_MBX_RX_TO_SEC * HZ);
> +}

The wrapper returns the result of wait_for_completion_timeout() which is
non-zero (remaining jiffies) on success and zero on timeout.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
> index b62b1d5b1453..193f554717b3 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
> @@ -178,7 +178,7 @@ fbnic_flash_start(struct fbnic_dev *fbd, struct pldmfw_component *component)
>  		goto cmpl_free;
>
>  	/* Wait for firmware to ack firmware upgrade start */
> -	if (wait_for_completion_timeout(&cmpl->done, 10 * HZ))
> +	if (!fbnic_mbx_wait_for_cmpl(cmpl))
>  		err = cmpl->result;
>  	else
>  		err = -ETIMEDOUT;

Is the condition inverted here? The original code enters the first branch
when wait_for_completion_timeout() returns non-zero (success). The new
code enters the first branch when fbnic_mbx_wait_for_cmpl() returns zero
(timeout) due to the added negation. This would cause successful
completions to return -ETIMEDOUT.

[ ... ]

> @@ -447,7 +447,7 @@ static int fbnic_fw_reporter_dump(struct devlink_health_reporter *reporter,
>  				goto cmpl_cleanup;
>  		}
>
> -		if (wait_for_completion_timeout(&fw_cmpl->done, 2 * HZ)) {
> +		if (!fbnic_mbx_wait_for_cmpl(fw_cmpl)) {
>  			reinit_completion(&fw_cmpl->done);
>  		} else {
>  			NL_SET_ERR_MSG_FMT_MOD(extack,

Similar issue in this loop - the original code calls reinit_completion()
on success (non-zero return) and goes to error handling on timeout (zero
return). With the added negation, success now triggers the error path
setting err = -ETIMEDOUT, while timeout triggers reinit_completion().

