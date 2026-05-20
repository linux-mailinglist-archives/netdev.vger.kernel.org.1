Return-Path: <netdev+bounces-289763-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GIwFw47DWrfugUAu9opvQ
	(envelope-from <netdev+bounces-289763-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:39:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5119587889
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 623E7300DE0E
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 04:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C072EACEF;
	Wed, 20 May 2026 04:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W+y/6/CT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D9D2D6E5A
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 04:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779251979; cv=pass; b=gWXOfWUK2wbjxXAW+4491jc3/D3oa+4KA7iBxz/iRtgKHVeTPyczasFdyDArNQBVskozjzZI2Gg+b9NxVZOczWMasKWdhdTFF6VX4n/0y386jPO7XWEnixNjLgpxUKYCC4HRrC9vut8X8YWsb9c5qiK3iMLE2ucsEgmUfxGD7Js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779251979; c=relaxed/simple;
	bh=P14/4Bqu5uUuw06j+SRo4HPvnUgRVexcBhmq9ZxsP+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IJBC39LbRKac9InfcBnGdTOkNrAq/UbQvFsx3YApCISX7fW//oazJgQHux/lP3dJ9eRC/0K3bUldmAgvxasYAh5tZMrZHI5A7K0Y6IHVUV3Xvd7LEQTJKXB93bsQ4XxjAATFD2CVR6csng/Acevp9G4xCmnWsa4cfIYY60wRlWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W+y/6/CT; arc=pass smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-912575fa768so753771685a.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 21:39:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779251977; cv=none;
        d=google.com; s=arc-20240605;
        b=igAAg3dvYnoNE4hVGYai2HsmHKNzZoAJupB0LBEWN4egNA9zoAOr6zSx3WcaRLCO8Y
         /CWWCQ3chp81C3sW4DxPgtkVZWoAhK8sH0z2FvoDalEARR0FgLbhDLVRm8DvrCPd8zQI
         zNz7f/aQTSjDr7rbiSfGg3gVQMSRVH9kZNjMSkCorPLT5z6vt3opMsn+XWZdI/KQ9XmC
         Tic2RrBzLR2EDjzhqHMfcS3RD/3JbfaDdAPGsW1hfPs5DmbYQaG6Xp9y0BqwGBA0rcCD
         yLHUKtlbXwC1wK0VVSldSiig9bS6oOYqIfoaCRMj7XByRoz9aWVEQX+2CUSd/IdP+Be5
         qxsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YVPSHkBYcknNlvutxyF1vq8PwV3dsuW7+IYZ8sKOiMo=;
        fh=g+3+MkrhvsSn7ltrOkr4QBjccdX0nmCKGLlEqsquM1g=;
        b=XMIDYQNs6xM+Xgct2Ns8HBkYUZ+P0Rw4fsFkxhh3Lvvi7Wod2TI9MVBA8rfRl1SqwW
         TbmmBzhiWdFLy1STevLkpTc+q27NMZR/bFv198hGow4q7DuyAIqHJ3ocioPeQWfz5Hkj
         2Zb9CVnXKFFJUZkdYJhF6NFfGwZT+8mSzRmS2p9dM29tgjs3reMAhbV/Ed8Mzqxo2o8i
         CPa5RGIScdF1vP187Ei3V2RuURxuORt8h59p0/DTsmSHw0kLxMa3TWeCwEX57GXQ6lJV
         cCrBt1RyH2iltYUuTXmuEP9Eg1tCgL/luI79vEp/c2wct5uxAAU+qQcvKEvuya66qDRj
         e6XQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779251977; x=1779856777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVPSHkBYcknNlvutxyF1vq8PwV3dsuW7+IYZ8sKOiMo=;
        b=W+y/6/CTKc0MAFltSXmlz02Gjjl8iXwTym2khhlJTAsSb5p3LA8MyRonu6k2Ko9MSl
         NTBHJFq+knMDlFQCPd6YT8duMhqbUJ6uDQtL5P3Yvh5/wh8vk0UxYZGpRsazPMAGHo5B
         sVCf55PI2bZ5DXzH6smua9S7d9THWXHrmp9rJYt/7aC9bS8uitI+bNMWrIL+PMIi1ptz
         m6ONrLaYBsadbPUpG38tgG4W7SqgGWy1cwLCdPLqRcNZgd5fwYrSeyZpeUrdZANFjbY3
         zGIAvpU5gIjZechlh02hy3n/f/l84BPt/aTwwhKep0HZgyrtOPe8rRjihBuSAJpGEKTH
         Tifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779251977; x=1779856777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YVPSHkBYcknNlvutxyF1vq8PwV3dsuW7+IYZ8sKOiMo=;
        b=EVQyfog2Z/xaelRKOvL2Z6iaJfcLiA16foN6oJO9G1br+oq1fNOC5ZHBuKNGhzBLvq
         cC840OnVpRBd3jo0QX1mDzMiHGj8IO05y9vIBeGMo5LpWjkZWXyIgJL1i9LK1M8G2stD
         rLWIPlO+TXN+oK9/dh0ApTphrWFludkNV1ZCAJACVMkYHtv/4JlkQr/tmaq/MgdRMrZC
         jhWw40m13u5N29RFLnH80XFI8eWT2n/exPrDBuWFxvEc8bwmkdwbT0i+8CMeaYcy98j3
         c48d3ZXDuyFnp9oQTxjzDvAXEaEBdtvFy8mkuy8XixKWBwrBVMG6i9BUYwkeydQxPzy0
         nsIg==
X-Forwarded-Encrypted: i=1; AFNElJ82pVOK5P/G3Xr/V2gxwRBJH76yF9A0Ru4gRlb0w4jWYYCuga2WWsUGFtnay9N2SORVrNlTD5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDKHyHf5vocVLCFuCBlgST6sT+bKCjkEVR4alDwkbx/5nmQPZT
	HqDtv+Oj6M/fOn6fLQ7SMJOale5fMS7gwaa15n2FlU/M4D4Dfr+Qgs3vacselydF2joTW5stamx
	pF4lhar54XaCsp7EBvbXSx2/RtX8RQE9kTqqIxekk
X-Gm-Gg: Acq92OFtTUlUIUknVstDjXjtXRYN6SPZeJjAMuqs9Q/3Lh0bt42DSfMfBwPmlsfhw1Q
	Nc8qF4HlYUFo91XfOD18+oc2NjKnAdYHolk4znHsETvbHJqlhaQNDCphnhjTVIt+gi54TzkyKtO
	pGxHuxFjFzjceddwPLFgo+eY3qKro1STxz7V0NWl9/E0r+PXW/CGapNcdKlPVii5ty+pidsxeAv
	1dIy377jPkRsoNu6+cycKdrLduv3FDOJdxGbTT62XQlDTY2ZR0DB0NJWV9KAayuAkv2TCXwBedv
	FFVF6s4kVQPO2svcTQrZrsAM/xpYn3R9JDANbL2VTwczc6pa1uBhAQtgc1QXHUC0Ksh5rSrjdYT
	Jw2JL5JlrjXldYchcCusIOcCq3K7d4X5qsE9TGo9cLUVi/M1lNzugB4Ne2CfXJ7wA
X-Received: by 2002:ac8:7d94:0:b0:50e:5e8d:87d2 with SMTP id
 d75a77b69052e-51659fbe971mr323408931cf.1.1779251976863; Tue, 19 May 2026
 21:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518183424.3144867-1-sbrivio@redhat.com> <20260519190352.45c8478e@kernel.org>
In-Reply-To: <20260519190352.45c8478e@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 19 May 2026 21:39:25 -0700
X-Gm-Features: AVHnY4IDfMyDXWooEL9P52eF0h3DnkFqEfpX7HmWX44NJSeGokXsyph8DZz-2k0
Message-ID: <CANn89i+DknqarcKuZxku-XvoioqkXrd3sQd3PXW5fdFZBpPxjg@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] Fix race condition between TCP_REPAIR dump and
 data receive
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stefano Brivio <sbrivio@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Pavel Emelyanov <xemul@scylladb.com>, 
	Laurent Vivier <lvivier@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, 
	Jon Maloy <jmaloy@redhat.com>, Dmitry Safonov <dima@arista.com>, Andrei Vagin <avagin@google.com>, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289763-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B5119587889
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 7:03=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 18 May 2026 20:34:22 +0200 Stefano Brivio wrote:
> > Stefano Brivio (2):
> >   tcp: Don't accept data when socket is in repair mode
>
> Not sure Eric is on board with this patch in the first place.
> Sound like it's not the intended use case for REPAIR so IMO
> it's up to TCP maintainers whether we want to support this.
> And it's definitely not a Fix.

I am not on board. Only net-next material for sure.

While v2 is slightly better, we have the fundamental problem of adding
stuff to TCP receive path for features that almost nobody use.
(It took more than 13 years to finally complain about the race)

This consumes Gigawats of power on our planet (and tons of CO2), given
the trillions of packets processed every second.

Please at least add a static key as we did in:

commit 020e71a3cf7f50c0f2c54cf2444067b76fe6d785
Author: Eric Dumazet <edumazet@google.com>
Date:   Mon Oct 25 09:48:24 2021 -0700

    ipv4: guard IP_MINTTL with a static key

    RFC 5082 IP_MINTTL option is rarely used on hosts.


But in my original feedback I pointed that we TCP_REPAIR should
probably only insert a TCP socket into TPC established hash table
only when it is ready to process incoming packets.



>
> >   selftests: Add data path tests for TCP_REPAIR mode
>
> Please don't add a new target, fold it under net.
> Targets are a PITA to deal with in kselftests.

