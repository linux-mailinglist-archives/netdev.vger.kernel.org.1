Return-Path: <netdev+bounces-256419-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLYxHDE8gmmVQgMAu9opvQ
	(envelope-from <netdev+bounces-256419-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:19:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E33A2DD779
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B78F330A451B
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 18:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A28C3D3487;
	Tue,  3 Feb 2026 18:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQoCM9nl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638AD31B83B
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 18:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142659; cv=none; b=tEO9gRppzTumpimq3hcwDcGTIAN7myj9cVKPbcioQDvr46vifjhhQ/6LXpSBh4CxV6MxX33RfmDkz9Ysw5+mk3JhAG01Kdwk7tDrOuDe0qAKklGJrPy75IlLLduXGfYPHWJNttgCVGbhLGjHN5eXD4RnqlEJparZbKUH2TCMmhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142659; c=relaxed/simple;
	bh=cPxuwbokChawhBR2aJF0YsS2ia7mjo7SWH5dY97bhbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UShOt5N7ThgMMEDsY6F6mrd3ItFnwOjmpxcTZ/rIYJXtb/h0Gt8CJ3Lr02jKeKhO7azEBZh1BkAlBCR42apq+9WzLMDCo9J8JyIS882XxqLEwFesx09SA6XKxcyDxNfkOy+qlKs9tEL6Nz+WPN9siTdua4tSZfAXQclcgSdA0fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQoCM9nl; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-649b1ca87ddso3486423d50.3
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 10:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770142656; x=1770747456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IfQQ/hkIcrRAkW7v/0G9Sw2aYsY9fMOv4jWxru/t/J8=;
        b=VQoCM9nluV/MckcgwJYwMR3GkZ735jdk4IrWPEyD8ZQF4bAvJQEBp+5fHx8o2BWv+x
         chYOsmBLwhhmWq7N0IoRLXHbwzimEF0Jmk1zMbtVRdmnzpPZ6C7ZSqBBa2QKh7E8y1Rt
         FVnAT4SZpiXZFAp8FE83IV0623TVPTpOTmWTiP5Vgz6aOWY1rG722Y2J8wT0q0Wbwamd
         lqay/AtqAstKpp55o/QkcvbZDBiovmrT751c46AdeTljE2hhkBXbalLx9dMLOyb0rO6Z
         pa0X+zPzi9kl8JEeB3fvKs403tmM5lSK82+e/VCUi5iDN+96GHXrJ4JPLoiLw4C4w7L/
         hEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770142656; x=1770747456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfQQ/hkIcrRAkW7v/0G9Sw2aYsY9fMOv4jWxru/t/J8=;
        b=hPCLadq/JpktrzcPTTc9fyi+4uQ6Bo72S4xfMLzjUBAVYKdJO0CYUVESr0n7zK25iu
         4AgD+3/apyG8D88kV7VQvi2AlKzWLratC/BMxPi5A5HikUClYaTjwIEDSgyE7Ulsu9s9
         GdULAqIdgVEQFMuY6nn6hnlyNyargO14CsyZsBx3/EDHf2HWUy8N/642pmbK5ZLZQjiU
         Sf5+Y8ls4xS3BcyZxj7+iQfevndR6RpU/liw6vzCyDAsKU84SU4DHzu/Qo+l2dCx08pY
         GfK+lLKsDRMQLTVX4vZuGS7qc+D5fHILub3QsSnbOJ83KD//d+u5pDASPYtl3h5ztW2Q
         /aMA==
X-Forwarded-Encrypted: i=1; AJvYcCWYnoIQ0pDxComy3O8CUbVqvK+k8dbZXi6CBU1q0oDz4raOz2MPiZ6gIUDhj3s+w3VfM1M5PnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq4dZGqW528tqJorzu0Kdx5h1XFkgIWbmMbQ1hfXdFDb6ItL9Q
	yrgPsWmpAXDa0wV5K0iaqYd9asUkjDbsaPiGis4ZTg3tEFDVkLxIc3Zs
X-Gm-Gg: AZuq6aLUyAfgN7hPPwRJo+ikD6Ui1mjrlgm3Y3PB2x8h0E5kGD51F/DXMBr54cv6Md4
	YXUq9zfVeaJ9H07UJblN0AY+vbjOKKLpQBodh4FcRUXnWZk6yjZfrMYR2aHiUJT0RQaKGrSgZdw
	Rl9rdbGS7KfDWnpbbg59/CXvKtRCa5M0YrbScsKU7ltfFVEq0RYggxaBmlf3/k/+RqO9f3xXbs5
	dMRxgwsonOPKzWXPiaJqiUpDCMwyie4M3DJnUE9se17oLfwwi/UN9++cJFzXUA+PmcJ8T47NmVB
	gNvv2LF/A6qCT+7brDnNN0yTMoIaZ/6dTDSMpQJET+KQqP+QqUkueLyE1o5vvTAHl6I3zAXyPe5
	TaMtfc26ZQ+lprVxlG/UuGLQmxHhQT3Hcn/RH5HcJIHHanpd438mO4+zWml1gnc61Gsa1Nwkq2o
	Z9TCcdcRIUqTV81NtbsvvxJg0gne2Joj7lx37NlgbWyzrdXBVvLvf7hiy9Xiqjfos5zFs2wNiiA
	IWVZ0xgv2+6SfUwW8jx
X-Received: by 2002:a53:d249:0:b0:649:c512:1430 with SMTP id 956f58d0204a3-649db3483admr346374d50.26.1770142655428;
        Tue, 03 Feb 2026 10:17:35 -0800 (PST)
Received: from devvm11784.nha0.facebook.com (fwdproxy-nha-036.fbsv.net. [69.63.189.36])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649dc5aca33sm65624d50.14.2026.02.03.10.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 10:17:34 -0800 (PST)
Date: Tue, 3 Feb 2026 10:17:27 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Simon Horman <horms@kernel.org>,
	HarshaVardhana S A <harshavardhana.sa@broadcom.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH] vmw_vsock: bypass false-positive Wnonnull warning with
 gcc-16
Message-ID: <aYI7twgCsAQSAiZk@devvm11784.nha0.facebook.com>
References: <20260203163406.2636463-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203163406.2636463-1-arnd@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256419-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arndb.de:email,devvm11784.nha0.facebook.com:mid]
X-Rspamd-Queue-Id: E33A2DD779
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 05:34:00PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The gcc-16.0.1 snapshot produces a false-positive warning that turns
> into a build failure with CONFIG_WERROR:
> 
> In file included from arch/x86/include/asm/string.h:6,
>                  from net/vmw_vsock/vmci_transport.c:10:
> In function 'vmci_transport_packet_init',
>     inlined from '__vmci_transport_send_control_pkt.constprop' at net/vmw_vsock/vmci_transport.c:198:2:
> arch/x86/include/asm/string_32.h:150:25: error: argument 2 null where non-null expected because argument 3 is nonzero [-Werror=nonnull]
>   150 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
> net/vmw_vsock/vmci_transport.c:164:17: note: in expansion of macro 'memcpy'
>   164 |                 memcpy(&pkt->u.wait, wait, sizeof(pkt->u.wait));
>       |                 ^~~~~~
> arch/x86/include/asm/string_32.h:150:25: note: in a call to built-in function '__builtin_memcpy'
> net/vmw_vsock/vmci_transport.c:164:17: note: in expansion of macro 'memcpy'
>   164 |                 memcpy(&pkt->u.wait, wait, sizeof(pkt->u.wait));
>       |                 ^~~~~~
> 
> This seems relatively harmless, and it so far the only instance of this
> warning I have found. The __vmci_transport_send_control_pkt function
> is called either with wait=NULL or with one of the type values that
> pass 'wait' into memcpy() here, but not from the same caller.
> 
> Replacing the memcpy with a struct assignment is otherwise the same
> but avoids the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  net/vmw_vsock/vmci_transport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> index 00f6bbdb035a..a64522be1bad 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -161,7 +161,7 @@ vmci_transport_packet_init(struct vmci_transport_packet *pkt,
>  
>  	case VMCI_TRANSPORT_PACKET_TYPE_WAITING_READ:
>  	case VMCI_TRANSPORT_PACKET_TYPE_WAITING_WRITE:
> -		memcpy(&pkt->u.wait, wait, sizeof(pkt->u.wait));
> +		pkt->u.wait = *wait;
>  		break;
>  
>  	case VMCI_TRANSPORT_PACKET_TYPE_REQUEST2:
> -- 
> 2.39.5
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

