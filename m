Return-Path: <netdev+bounces-291117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BKbONK/EWoNpgYAu9opvQ
	(envelope-from <netdev+bounces-291117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 16:55:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE8A5BF7BD
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 16:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DDFB3014281
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 14:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E3525B08D;
	Sat, 23 May 2026 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CZm3mvm9"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7841E8826
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779548036; cv=none; b=fUQbAeULlIMDmtkiz9nUTLl9oETjRO7LtYyuw1BkrYbEgeuk6iW9G/qR5CZGYgxPyNkUYDKBexn6u4frccMb40ABldyGFPs/rap6s/qI9S5wt8Y9xWUDtyuMrneUr80pYAIhr9f3/+lEdIKuPb2yCFUPt/cZkhuUFDC9u8wf1WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779548036; c=relaxed/simple;
	bh=WAV8G8BbiIPGtxLgmb0Xcf9L2MrypMvKo8ercFnYBZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XybsoW/rglUrSIcaawnhsmTBR+B6ali6srnIH86Pc4XtfmoSgYoDs4jCzifUcQVJaGQslLylrXiF5gFpZfL44vn5JfwIYwwzvNpVSYsuLfgbvubVffu1VGZT/f1sfY+rLezV8U2nsmJ3f9W9GvdCQ0+XBMqWNO2W8dCzViXgi+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CZm3mvm9; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C11F7C2C663;
	Sat, 23 May 2026 14:54:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7B70C60733;
	Sat, 23 May 2026 14:53:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DCE9810811D8A;
	Sat, 23 May 2026 16:53:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779548031; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Guo56gaS5J5FzbdvDv2eH+CWoIumg7pah/jfH39GeUE=;
	b=CZm3mvm97Hisz3qlbTCcnq+yraFJRR9WDBvc7BSTv2YHueaBR9FJgNh0C3Oa8Agc2dbOEh
	HnkUNtWygJJETSo2WZMkoxIj/vR3zFPSPrhYIFTdRMwSbtBVBOPGp0CT+0lmwpq7EA2Rhr
	8pMU6dc2qKsDHoyR8S442VPtoZTj3wVarPN2SaU48k+76Z7XIpDoUE4v7vr2oURG/kVQke
	aTKQ7AKeE9f9F2FgmU1Bnhg1vj5CMyAz/EWBWVVSd3QGLayc2hGgvAicN2FRRfg1uBZqLt
	Za3gVg+qGWbfiGNLrBUCeb/9BOq0fac/sLxV+B3x5UXvgfR60OCxHMZuWodq7A==
Message-ID: <b02fc4d9-2430-459c-82de-c3abbea798fb@bootlin.com>
Date: Sat, 23 May 2026 16:53:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 7/9] ethtool: cmis: fix u16-to-u8 truncation of
 msleep_pre_rpl
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, danieller@nvidia.com,
 petrm@nvidia.com, o.rempel@pengutronix.de, idosch@nvidia.com, andrew@lunn.ch
References: <20260522231312.1710836-1-kuba@kernel.org>
 <20260522231312.1710836-8-kuba@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260522231312.1710836-8-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291117-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,lunn.ch:email]
X-Rspamd-Queue-Id: 4CE8A5BF7BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 5/23/26 01:13, Jakub Kicinski wrote:
> ethtool_cmis_cdb_compose_args() accepts msleep_pre_rpl as u16 but stores
> it into the u8 field ethtool_cmis_cdb_cmd_args::msleep_pre_rpl, silently
> truncating values >= 256. Seven of the nine call sites pass 1000 ms
> (it's the third argument from the end).
> 
> Fixes: a39c84d79625 ("ethtool: cmis_cdb: Add a layer for supporting CDB commands")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
> CC: andrew@lunn.ch
> CC: petrm@nvidia.com
> CC: danieller@nvidia.com
> ---
>   net/ethtool/cmis.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ethtool/cmis.h b/net/ethtool/cmis.h
> index 4a9a946cabf0..778783a0f23c 100644
> --- a/net/ethtool/cmis.h
> +++ b/net/ethtool/cmis.h
> @@ -63,9 +63,9 @@ struct ethtool_cmis_cdb_request {
>    * struct ethtool_cmis_cdb_cmd_args - CDB commands execution arguments
>    * @req: CDB command fields as described in the CMIS standard.
>    * @max_duration: Maximum duration time for command completion in msec.
> + * @msleep_pre_rpl: Waiting time before checking reply in msec.
>    * @read_write_len_ext: Allowable additional number of byte octets to the LPL
>    *			in a READ or a WRITE commands.
> - * @msleep_pre_rpl: Waiting time before checking reply in msec.
>    * @rpl_exp_len: Expected reply length in bytes.
>    * @flags: Validation flags for CDB commands.
>    * @err_msg: Error message to be sent to user space.
> @@ -73,8 +73,8 @@ struct ethtool_cmis_cdb_request {
>   struct ethtool_cmis_cdb_cmd_args {
>   	struct ethtool_cmis_cdb_request req;
>   	u16				max_duration;
> +	u16				msleep_pre_rpl;
>   	u8				read_write_len_ext;
> -	u8				msleep_pre_rpl;
>   	u8                              rpl_exp_len;
>   	u8				flags;
>   	char				*err_msg;


