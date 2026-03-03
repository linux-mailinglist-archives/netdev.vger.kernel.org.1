Return-Path: <netdev+bounces-263070-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCoBMSmapmnfRgAAu9opvQ
	(envelope-from <netdev+bounces-263070-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 09:22:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1258D1EAB6B
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 09:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D93B30920B3
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 08:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AEC3242BA;
	Tue,  3 Mar 2026 08:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l8h5isQC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29CA386555
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772525876; cv=pass; b=Z/Af2QTPO774lrZ7FjpOxl2yJt/BKl7ylVovXpF9nvPIPymkTVs9VmL5uqaUL8c+NgSR9Hbl19AGflcVVR1cNeYputqNwqj63tXe7kBXgaa73dIL4peV4G/we1m7H4Hfu8n50D+s4YBHFHTPeBVOi3o3rtoRY8p81zNe0dJVKTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772525876; c=relaxed/simple;
	bh=BKP3hrTs/yJMOn+88yvtuxbyUogWcwezmgwIQCpgsU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWcL+H5PdFe3BsPlFn03b0VIKgebc/jnZjzV/UvdICOoanbKmKnCa149PTEvutlsORhJ6unOOTUKcd7OUeQ+/V0LgU5qRoa3NBUKIG+OkU2CM7+XSQLZjbg7H7+OFGRaNaxvrcLTOSJA7aPXxloMZ4VUjkMuM/sPuGLHy6LyyQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l8h5isQC; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-503347dea84so60590801cf.3
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 00:17:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772525867; cv=none;
        d=google.com; s=arc-20240605;
        b=C4tGQv51CaYQyaYqkB8HQlycXuQOj11+WGdRjpfXRYv0M1EAG6YlRzYjA7MulpssHn
         TGOE347OsQkqyDDANMaP2xar8dtE/9rNoMc8yfHkwP2f4uwS9llKBaG3XzJvckr362nW
         zOCmbbWUOova2blpuvMq1fU9UrJcsitSIPZDf2FPOzkQSWVIFUWU1elC6Jak4j0WDRTE
         H//kktzbeNkGZkWO2qrjS4pKWb7oxRQYUjiO7jp0Nt1emTx1OLZGu4TMlWjqAESQqjw1
         IQVSv63ut1fhmYX8uASVTa9k0QdZHRVzzBFktaCFl5bhI/tEHXLWMDrwbElTES6zAIFi
         07Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BKP3hrTs/yJMOn+88yvtuxbyUogWcwezmgwIQCpgsU0=;
        fh=boiL+SLn/FBS2qpfzltfvYC9IBzELXsq/aOJcTOwweo=;
        b=TZty2IN3Mu4FGYIwpHBxLNtnejCoitkK2ZEB/fDkruEvWMlbJz6/9F/0GmA8GxXf3j
         kZZ3VdYiBwPOgdvSUYuRe0VRc5eHqmgmjpbx76wfnGnghDkm5cgJQ7EzEzA/sI0SxkAP
         lKi6VX+PJAeA/6Xuphj0Ju4JrOpKTON8ik95i9OM+zacZGyx03tMQDyDO1kGwAulMFbo
         tD/UY4Ve813k+6LGbaQ8YVLRy167CWBhfsytIFEPQu1Gpab2PGYD1cniBU/ZjKk2GNpo
         LpKMFW65yI7eknIZWVEEo9/RfN2MyMqXAebCViF0OvUINdEVsVUQaChcaAHaOOZvIGD2
         u/3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772525867; x=1773130667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKP3hrTs/yJMOn+88yvtuxbyUogWcwezmgwIQCpgsU0=;
        b=l8h5isQC2svVpHaYNHyrVSIJm51TmLPoMS7cXoqojeij0fTIaHljOqfwBiD2TC0lpm
         z4AGvXSCY4sxl30WmLM9r2G10hCPnCp4Eb4YKTH3AV+xJ7iVwJ2wRoaIF7zpqr9CgGeZ
         j6EuGh8VvZ/RcqtwdDKV+bRf+whaSEKfV16+xEiwLkKR46fyJ65aZ9NZyu/zfiaf/VvN
         AiuyAzypWsVXeULOp1aKGJz6ijfgIB3/XbpfOx4Nm/WHKkVjcB5UYtl7nUOMhQqbELHE
         0e79zOL1+1JJNmXO1dpG4IrENLyc/tnpGeihuyJr0FKakAXU/ktV0JCy3jr+ngfrhPrb
         N1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772525867; x=1773130667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BKP3hrTs/yJMOn+88yvtuxbyUogWcwezmgwIQCpgsU0=;
        b=LF1P5vn6T1Tqr2E4FunkEkrWxCKAIGQRNQvIQwDPGmohGIjYbbfYq2CFbhVg9FwQ1X
         BN6Px2oKDNR5rpfExWnHxKueKeORZ44ewFlY8KqipxN66BUYOQZmIxG7M2gwjH5SdAYD
         HdFMcCTnvRRCZAhH2Rz84Xvow27E50RSAyOz3vprhq3CPCSm2OVx4zSE7gXIAwEbrZrn
         PgCtVMo+8CrybHIlmhs0g8wlr/6Q8DiNkiU0Wi+9lhnIH9cqfzHjYIDg7m/gWFWq41md
         Ju0xvSgbg8MfltTJgR/QOJ/TFh9hM6AVf385DRejq/DK4BsnZC38zqeuY0LGuPYkHF3S
         GtCw==
X-Forwarded-Encrypted: i=1; AJvYcCUU9IwWTNi1lEP9DhsDD104LnMJ2gSSndQwDEawhsJ5ktV/ifbUw3thPeGCO2Tom6pXfh2XdNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhCj8rEux0JSH/VoJGgGjZDq0DikuemO2teSXtCt4EKug3YbNX
	tWgAeDkXZX2AINkDM6V6SG8aSVhBkhk9RAVsmM/6FZMSi9J6a5Tu4MZk31yFBegqM5jHp8kcTKi
	V82MEIFjVKDOeogdgmIyITEirfEnupkieRXGeMY5y
X-Gm-Gg: ATEYQzz+/Vzb3R6sARv4/4oUoJ6y8me4gob+0PeQgLZW7aY/J1hV81tno14yE2pwko3
	MnQLxne7kLVN7QZzZtib9wMQx29RnApJEyNHJsQUV/r1yNk5u3lOCl4bhgYaE3uxVjz12DwB6LG
	SFke6vrimlja+rBR8rvyyR6hSr/OwFZnelkDD+2COjLlOvCBWIKgOI5r/ISM8HXywvNiM7liGdc
	myuY5DeMd1Ipso0tuhT3hp/470GKYrb9OdD38aOuhkWJKoWVHsZ6zqNte+VLMjqkxe/pepGuSDV
	VZ0+pg==
X-Received: by 2002:a05:622a:178d:b0:501:4e87:70b7 with SMTP id
 d75a77b69052e-50752726318mr194022051cf.1.1772525866886; Tue, 03 Mar 2026
 00:17:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225074633.149590-1-leon.huangfu@shopee.com>
 <20260225174354.5a698ddb@kernel.org> <f611be70-8280-44c8-86af-5866c0b302be@linux.dev>
 <20260302162251.733b520e@kernel.org> <3a623176-fc5f-4dd4-bbfc-64d211f53645@linux.dev>
 <CANn89iJ0=Tx0i+1UXEdcoFuk1F_MfP41-L-kgGDTN+RcLTRcFA@mail.gmail.com>
 <d7f3dabd-e6da-496d-927e-590a41dee009@linux.dev> <c582ab1c-8a2d-4c0f-ad7b-7d44fe4296f6@linux.dev>
In-Reply-To: <c582ab1c-8a2d-4c0f-ad7b-7d44fe4296f6@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 3 Mar 2026 09:17:35 +0100
X-Gm-Features: AaiRm51_I2l9ysvKbWyHiFJhEEte-0RPshulRKBNv6aB9EQb1ph-WXKtSAhZ4nE
Message-ID: <CANn89i+Bt_AZK=16nekvs846P7fPWxkRrNaNNBOrH0sB7xS1uQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] tcp: Add net.ipv4.tcp_purge_receive_queue sysctl
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, Leon Hwang <leon.huangfu@shopee.com>, netdev@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ij@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, kerneljasonxing@gmail.com, lance.yang@linux.dev, 
	jiayuan.chen@linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1258D1EAB6B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263070-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,shopee.com,vger.kernel.org,davemloft.net,redhat.com,lwn.net,linuxfoundation.org,google.com,nvidia.com,gmail.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 8:55=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
>
>
> On 3/3/26 14:26, Leon Hwang wrote:
> >
> >
> > On 3/3/26 11:55, Eric Dumazet wrote:
> >> On Tue, Mar 3, 2026 at 3:12=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>>
> >>>
> >>>
> >>> On 3/3/26 08:22, Jakub Kicinski wrote:
> >>>> On Mon, 2 Mar 2026 17:55:59 +0800 Leon Hwang wrote:
> >>>>> On 26/2/26 09:43, Jakub Kicinski wrote:
> >>>>>> On Wed, 25 Feb 2026 15:46:33 +0800 Leon Hwang wrote:
> >>>>>>> Issue:
> >>>>>>> When a TCP socket in the CLOSE_WAIT state receives a RST packet, =
the
> >>>>>>> current implementation does not clear the socket's receive queue.=
 This
> >>>>>>> causes SKBs in the queue to remain allocated until the socket is
> >>>>>>> explicitly closed by the application. As a consequence:
> >>>>>>>
> >>>>>>> 1. The page pool pages held by these SKBs are not released.
> >>>>>>
> >>>>>> On what kernel version and driver are you observing this?
> >>>>>
> >>>>> # uname -r
> >>>>> 6.19.0-061900-generic
> >>>>>
> >>>>> # ethtool -i eth0
> >>>>> driver: mlx5_core
> >>>>> version: 6.19.0-061900-generic
> >>>>> firmware-version: 26.43.2566 (MT_0000000531)
> >>>>
> >>>> Okay... this kernel + driver should just patiently wait for the page
> >>>> pool to go away.
> >>>>
> >>>> What is the actual, end user problem that you're trying to solve?
> >>>> A few kB of data waiting to be freed is not a huge problem..
> >>>
> >>> Yes, it is not a huge problem.
> >>>
> >>> The actual end-user issue was discussed in
> >>> "page_pool: Add page_pool_release_stalled tracepoint" [1].
> >>>
> >>> I think it would be useful to provide a way for SREs to purge the
> >>> receive queue when CLOSE_WAIT TCP sockets receive RST packets. If the
> >>> NIC, e.g., Mellanox, flaps, the underlying page pool and pages can be
> >>> released at the same time.
> >>>
> >>> Links:
> >>> [1]
> >>> https://lore.kernel.org/netdev/b676baa0-2044-4a74-900d-f471620f2896@l=
inux.dev/
> >>
> >> Perhaps SRE could use this in an emergency?
> >>
> >> ss -t -a state close-wait -K
> >
> > This ss command is acceptable in an emergency.
> >
>
> However, once a CLOSE_WAIT TCP socket receives an RST packet, it
> transitions to the CLOSE state. A socket in the CLOSE state cannot be
> killed using the ss approach.
>
> The SKBs remain in the receive queue of the CLOSE socket until it is
> closed by the user-space application.

Why user-space application does not drain the receive queue ?

Is there a missing EPOLLIN or something ?

