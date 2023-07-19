Return-Path: <netdev+bounces-18882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A60758F50
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 09:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C75B82812D2
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 07:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB34CC8E4;
	Wed, 19 Jul 2023 07:41:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C47C8C9
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 07:41:16 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5711FF7
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 00:40:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D3BCE218E1;
	Wed, 19 Jul 2023 07:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1689752448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BWmFxxqN27ugO7tzWmSzKo+0/UwvNqjHaRByoUZ2zsQ=;
	b=UUpbg3IHG8spHmH6ow2evc0IPD+Jf7Zq2n7lT+/IIgFgmfusS4ZvJuc3ERUxfBB8lR+4pG
	dB1BnJm+YJz5DiwkmG+/9VhL0hV6Euje4M3CtrrYOvyzHQ8neohc5dzUzW5QQzzTQuaZfP
	52dkpT/iRtSXnqDT2FuWuPYOV6cP0aQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1689752448;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BWmFxxqN27ugO7tzWmSzKo+0/UwvNqjHaRByoUZ2zsQ=;
	b=pa2BS2GE/9xQmkvsCjTGEQUmv1eRc2T/bYrZPjwo3qbPAp/ioqWza0UJK3nFq96n0v2I3I
	i2Xj8xlQ5+DzeOCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB7A013460;
	Wed, 19 Jul 2023 07:40:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id sxpoLYCTt2RsYwAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 19 Jul 2023 07:40:48 +0000
Message-ID: <65a78771-d820-2337-363e-a29f3f144c15@suse.de>
Date: Wed, 19 Jul 2023 09:40:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v1 2/7] net/tls: Add TLS Alert definitions
To: Chuck Lever <cel@kernel.org>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
References: <168970659111.5330.9206348580241518146.stgit@oracle-102.nfsv4bat.org>
 <168970677480.5330.16194452237553219882.stgit@oracle-102.nfsv4bat.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <168970677480.5330.16194452237553219882.stgit@oracle-102.nfsv4bat.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/18/23 20:59, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> I'm about to add support for kernel handshake API consumers to send
> TLS Alerts, so introduce the needed protocol definitions in the new
> header tls_prot.h.
> 
> This presages support for Closure alerts. Also, support for alerts
> is a pre-requite for handling session re-keying, where one peer will
> signal the need for a re-key by sending a TLS Alert.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   include/net/tls_prot.h |   42 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
> 
> diff --git a/include/net/tls_prot.h b/include/net/tls_prot.h
> index 47d6cfd1619e..68a40756440b 100644
> --- a/include/net/tls_prot.h
> +++ b/include/net/tls_prot.h
> @@ -23,4 +23,46 @@ enum {
>   	TLS_RECORD_TYPE_ACK = 26,
>   };
>   
> +/*
> + * TLS Alert protocol: AlertLevel
> + */
> +enum {
> +	TLS_ALERT_LEVEL_WARNING = 1,
> +	TLS_ALERT_LEVEL_FATAL = 2,
> +};
> +
> +/*
> + * TLS Alert protocol: AlertDescription
> + */
> +enum {
> +	TLS_ALERT_DESC_CLOSE_NOTIFY = 0,
> +	TLS_ALERT_DESC_UNEXPECTED_MESSAGE = 10,
> +	TLS_ALERT_DESC_BAD_RECORD_MAC = 20,
> +	TLS_ALERT_DESC_RECORD_OVERFLOW = 22,
> +	TLS_ALERT_DESC_HANDSHAKE_FAILURE = 40,
> +	TLS_ALERT_DESC_BAD_CERTIFICATE = 42,
> +	TLS_ALERT_DESC_UNSUPPORTED_CERTIFICATE = 43,
> +	TLS_ALERT_DESC_CERTIFICATE_REVOKED = 44,
> +	TLS_ALERT_DESC_CERTIFICATE_EXPIRED = 45,
> +	TLS_ALERT_DESC_CERTIFICATE_UNKNOWN = 46,
> +	TLS_ALERT_DESC_ILLEGAL_PARAMETER = 47,
> +	TLS_ALERT_DESC_UNKNOWN_CA = 48,
> +	TLS_ALERT_DESC_ACCESS_DENIED = 49,
> +	TLS_ALERT_DESC_DECODE_ERROR = 50,
> +	TLS_ALERT_DESC_DECRYPT_ERROR = 51,
> +	TLS_ALERT_DESC_TOO_MANY_CIDS_REQUESTED	= 52,
> +	TLS_ALERT_DESC_PROTOCOL_VERSION = 70,
> +	TLS_ALERT_DESC_INSUFFICIENT_SECURITY = 71,
> +	TLS_ALERT_DESC_INTERNAL_ERROR = 80,
> +	TLS_ALERT_DESC_INAPPROPRIATE_FALLBACK = 86,
> +	TLS_ALERT_DESC_USER_CANCELED = 90,
> +	TLS_ALERT_DESC_MISSING_EXTENSION = 109,
> +	TLS_ALERT_DESC_UNSUPPORTED_EXTENSION = 110,
> +	TLS_ALERT_DESC_UNRECOGNIZED_NAME = 112,
> +	TLS_ALERT_DESC_BAD_CERTIFICATE_STATUS_RESPONSE = 113,
> +	TLS_ALERT_DESC_UNKNOWN_PSK_IDENTITY = 115,
> +	TLS_ALERT_DESC_CERTIFICATE_REQUIRED = 116,
> +	TLS_ALERT_DESC_NO_APPLICATION_PROTOCOL = 120,
> +};
> +
>   #endif /* _TLS_PROT_H */
> 
> 
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 Nürnberg
Managing Directors: I. Totev, A. Myers, A. McDonald, M. B. Moerman
(HRB 36809, AG Nürnberg)


