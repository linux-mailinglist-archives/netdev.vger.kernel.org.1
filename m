Return-Path: <netdev+bounces-62657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258A88285D6
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 13:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30E0285B20
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 12:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4A0374F2;
	Tue,  9 Jan 2024 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKDsfRt5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AD4374CA
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704802498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cq+8s85RQhh5bKJVtHW6zd7HUwc+/ToYCSC97d+7VfU=;
	b=KKDsfRt5u88Bvaz17/lzQPlkCgTRz2EZ2QeOwrXLZswK88L2bm7qrN61jzUTQjljuE0NXI
	3Qsm14hNg5F1r/hF6BchMcPrATEj6yMVhiEl1KTVNS6KLX+3Hm0rUvxSP0/54qKxGLY8Ao
	o83fYEkHqCtGoYuDFDy84md04VYw0m4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-_FNtayH1O5mEA5k-J9nhiA-1; Tue, 09 Jan 2024 07:14:55 -0500
X-MC-Unique: _FNtayH1O5mEA5k-J9nhiA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a2703ed4789so20286066b.1
        for <netdev@vger.kernel.org>; Tue, 09 Jan 2024 04:14:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704802494; x=1705407294;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cq+8s85RQhh5bKJVtHW6zd7HUwc+/ToYCSC97d+7VfU=;
        b=IrdxplSf89Xc/oTF69XLimzL4ohb2grbi1oC24yURrSnHC9Re+mXmySjRwJ2YGfVid
         JCp0kTBAjWG633QS7MdkOsJc2WX/stt+6oMDzQVFnRFhtCXXTL60cTiKaIfAlpijd888
         xZYOVm7hjCZH2o3H1gGaGXr8mjds5DvZn6J6sV9LNCEsE924mJpwHuRVcd+AmDBWI4ZG
         FffZ4vmUowHpdeCeesrNg6pZBCi8skAsic2Eo5bUjnAGuLZJ5PmWGPr+zYLRxZktud1u
         AOu4zW4c3n1dwkiKiyj/aD2sqOJ+fBwMP3Y6vCq2GmRXcfYIoM5L+j8nXwP//Qkq7zbg
         Fx5w==
X-Gm-Message-State: AOJu0Yw+mFqCGbWvzpKxk4lws6JzXrVNEFtasVYztm3chLu4GtGBt0SY
	YkKV9kYWZTTywNibvnodK5LpdqiNUj6AMahW6oIFi0y2m0mZRSS7tvBQnHzAuiWpG1Svn60QrHW
	Bs3fbFkke18m+g/5ce1TXU69/85mle7Qi
X-Received: by 2002:a17:907:a44:b0:a26:d233:80b0 with SMTP id be4-20020a1709070a4400b00a26d23380b0mr5813707ejc.0.1704802493842;
        Tue, 09 Jan 2024 04:14:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBXzuPnOsYcFgWUIjd6hbczg2ddmzOfQbXE714rvdSQpFzONLXVYTGn1J1jdes1p/1ijDZqA==
X-Received: by 2002:a17:907:a44:b0:a26:d233:80b0 with SMTP id be4-20020a1709070a4400b00a26d23380b0mr5813692ejc.0.1704802493520;
        Tue, 09 Jan 2024 04:14:53 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-252-40.dyn.eolo.it. [146.241.252.40])
        by smtp.gmail.com with ESMTPSA id bm23-20020a170906c05700b00a26b44ac54dsm977975ejb.68.2024.01.09.04.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 04:14:53 -0800 (PST)
Message-ID: <88e2f7747f9692d1585d84a4c75a46590b9e76c9.camel@redhat.com>
Subject: Re: [PATCH net-next] net: bridge: do not send arp replies if src
 and target hw addr is the same
From: Paolo Abeni <pabeni@redhat.com>
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org, Nikolay
 Aleksandrov <razor@blackwall.org>
Date: Tue, 09 Jan 2024 13:14:52 +0100
In-Reply-To: <e5d1e7da-0b90-45d7-b7ab-75ce2ef79208@nbd.name>
References: <20240104142501.81092-1-nbd@nbd.name>
	 <6b43ec63a2bbb91e78f7ea7954f6d5148a33df00.camel@redhat.com>
	 <e5d1e7da-0b90-45d7-b7ab-75ce2ef79208@nbd.name>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-09 at 12:58 +0100, Felix Fietkau wrote:
> On 09.01.24 12:36, Paolo Abeni wrote:
> > On Thu, 2024-01-04 at 15:25 +0100, Felix Fietkau wrote:
> > > There are broken devices in the wild that handle duplicate IP address
> > > detection by sending out ARP requests for the IP that they received f=
rom a
> > > DHCP server and refuse the address if they get a reply.
> > > When proxyarp is enabled, they would go into a loop of requesting an =
address
> > > and then NAKing it again.
> >=20
> > Can you instead provide the same functionality with some nft/tc
> > ingress/ebpf filter?
> >=20
> > I feel uneasy to hard code this kind of policy, even if it looks
> > sensible. I suspect it could break some other currently working weird
> > device behavior.
> >=20
> > Otherwise it could be nice provide some arpfilter flag to
> > enable/disable this kind filtering.
>=20
> I don't see how it could break anything,=C2=A0

FTR, I don't either. But I've been surprised too much times from
extremely weird expectations from random devices, broken by "obviously
correct" behaviors change.

> because it wouldn't suppress=20
> non-proxied responses. nft/arpfilter is just too expensive, and I don't=
=20
> think it makes sense to force the use of tc filters to suppress=20
> nonsensical responses generated by the bridge layer.

Then what about adding a flag to enable/disable this new behavior?

Cheers,

Paolo


