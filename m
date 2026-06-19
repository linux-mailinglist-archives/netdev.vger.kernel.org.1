Return-Path: <netdev+bounces-300710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NoKMKNY/NWoyqAYAu9opvQ
	(envelope-from <netdev+bounces-300710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 15:10:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B99946A5FD7
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 15:10:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=fbPykfRQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300710-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300710-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A5F7300AC3B
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 13:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E594838759C;
	Fri, 19 Jun 2026 13:10:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBF3382F01
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 13:10:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781874643; cv=pass; b=t+SFfI0+DWfClD3Byv/uWP2/0MNMdIflht5qAZ4lpVQ8iEie7gmPiRNgZjY1F79s4YoEfP6Nkuow62v1EtB8w2mJLrqr/w47sSSqD84FtNzwM4tmf9UHc492SzvVzUmwLvYVygdEC+7ABLwVxKC3QFRRNOBOiIIoHeMyFZV00Pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781874643; c=relaxed/simple;
	bh=KYzW8Uf0cmBVtNrKmNAzwDTByjLgYkjs5lKiWcavIPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svO0xkWh6FstU/bH0Yv/oNHoKAv17lCqMeZXYPdr7dn/AkgIVxRU+yWbXbPFK35mSmmWyaQeC6YTzjqZ9MTO+G/fXNG9v8RkDS3PKdr7QBtjEyknLwF300auG0941wte2nUhmOZNk81fqjaIYkpbfYcEdW9YqPNRqcNnkTMg0H4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=fbPykfRQ; arc=pass smtp.client-ip=74.125.224.53
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-662dc3879acso2069417d50.0
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 06:10:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781874641; cv=none;
        d=google.com; s=arc-20240605;
        b=WAR7jn9Fkrn0SQG4UYT2kNODApx8dzguPsg3njW+V+Zv7H5ibkPqbEebMOgM8vZflg
         ydv4ogqPCc4Jl/W2Zviado7a0TdZz0/auNSWOnly7snu1m/4JJ39foPEg2bA5wxyAhEH
         DPQw6BWYueuBYbjhUzfgvKF4QrDv2Wa7ofZSHMDLg6xkL6yCLYCrDe8Led9u/B/1fg12
         eZ4X7MP0vs31Bup0I0fiVSGRTbn73Gs8PontpOWO7tqSpH5VeYtLiRoOOPw/UjyzJjvO
         zZaEP4lRZTZv+PLMgyzZA4nBbEEoM8gefudW0j0oTRyCQ1IoDfgtWdTQZNGpLVdwfDc4
         Wprg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Io1WyxEVa+vM9BlZnaCmyr4oxmiyFzlEAacCFJEPLlU=;
        fh=0lhTvtO4ndKUQTAUon8owB6JdvKSZrmVUwIaUW5RAKE=;
        b=OoxMZvewtYQrEFoX7V105JRnObgg2VK9W/WV3POAkoMCSx5JCKm1KNA8+wpMcCb0p4
         tp94LXFX6cT1UQDAtWNul1JSjrqggQn3RmZQkuTi9DC/iT4NN9whBJvSajQoYRAM5+i7
         PVZSL2NVl3fePIfglSl9DkuNPjy6/lNayNoxUXOdnWkkxtBpaeJxFkJkxeELHly2BBpG
         CBeL186/ug54o8Imx0SO+1ZdyJeUQ4e4MielAfU+RIatq4wHkTJBo9nfGvS89PLr903A
         ZL1HuHzJfk9voll1n8TSyZl+X11a3uPlDOV4tlXzNx49uurb7cRDyHOzIY6PLwprVDHS
         yxGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781874641; x=1782479441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Io1WyxEVa+vM9BlZnaCmyr4oxmiyFzlEAacCFJEPLlU=;
        b=fbPykfRQli9pTs5c/bDlBXaAbzFv+umEkA0gT6/2EY185ITl7HKPQ26NNIqUEDNuoL
         gikMrajk1BGoOd9CSmmd77Aokz9BqGlX0PRVkqOUwzxjHvKtT4UZ4Fdrf1zTEKX2Cgyv
         vFVRou9wb5rD3NNokTSIgbjpHh0BYi8H0xS7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781874641; x=1782479441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Io1WyxEVa+vM9BlZnaCmyr4oxmiyFzlEAacCFJEPLlU=;
        b=Tq5E7OIZaw5boABS43x8H/Svwv5hthWKqH+QE7VrV6n4gk5jhBrIlJh3KBujF4ggoP
         uoeqYK8MDGRUcUR/SRW8LgJsXvA5lrLeY8PnNfDjK+rcuR+vpaUtLofp/QY78vMKDPoc
         TltN40Aj7s9OMvoRXsRWcL0sDDRNcQNDg5jj52rIKYWm4FCDONMNfj1bt5o6Y5FYaAKY
         vvnHHnfJDJf6SP8XBaRx6Vl9U5YC7Hg+vOxf2cWewyfYbvT/sJ0CFs1eFvaJzDvyIUf4
         VmjJldCyrw7hLmABgEIPPcnqAij5YHSNsJURzZYUO654seadZ2iA4SpmkhzYD1ZKW1xE
         TJ/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/jzfQAA6WcbluZkWhmodBMbhmyqZorHzaE/Zjv8LxUqqqfYWVs8nQ2d8MIWtNtDM4F2bqVvhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSHUWRNDoiq3LHPFQenXwzcnC5c9fjddTTCh8IX1sySHMUgMFe
	1zxvWu/VESLBQti4kZw7QaTPQNEc2g+Kko7KuKOqE0c1DlcwwDarhvx/byRLka4m/NEDVpjvw/6
	9xLNKQNcili6M7FpBL/u7zdMIaBupCWF060Pddd1B
X-Gm-Gg: AfdE7ckFX4QyTO7KOF88USpUFUB3JRR3oYXJpdVeCsbI7CZxTAvXy1sPiVi78YFz0m/
	aANoB1bIhBRIipy00LIAaPl5jfZ3gBM+n+dBS2pdn+pHAVRFbVHd9ptF9jA5kwJ/18Oyk+2NZIz
	4BdqomXjlGB8rO601tp/Sffbs07bR+PqafgfcDYsFUy/lS9HGcgq1+CeY52rIUfoVth8vVFNTUQ
	VoajOibA47UsXqMR80AwYIoH7fVb2E6B9AFAouxjT4Z+UBs83oZr3cd/7nNzPU9Xel2ZTFnG1Jy
	mG5YwGlOxO85krsFAHT9uuXyXdk=
X-Received: by 2002:a05:690e:148a:b0:662:cea4:dd6b with SMTP id
 956f58d0204a3-662ffe0f73cmr2603812d50.61.1781874641147; Fri, 19 Jun 2026
 06:10:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619073211.637928-1-b1n@b1n.io> <20260619073211.637928-2-b1n@b1n.io>
In-Reply-To: <20260619073211.637928-2-b1n@b1n.io>
From: Victor Nogueira <victor@mojatatu.com>
Date: Fri, 19 Jun 2026 10:10:30 -0300
X-Gm-Features: AVVi8CelU6ok4Rdt_6M0gdLKdnsd41ObWBe81u404fCoHbvNwemubIfpn2XBnUc
Message-ID: <CA+NMeC_op2tQZjC-1xW-rCFD77uiB=dv-27N4_69GotRY81mmw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selftests/tc-testing: Add DualPI2 GSO backlog
 accounting test
To: Xingquan Liu <b1n@b1n.io>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:b1n@b1n.io,m:jhs@mojatatu.com,m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:chia-yu.chang@nokia-bell-labs.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300710-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,tdc_batch.py:url,mojatatu.com:dkim,mojatatu.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B99946A5FD7

On Fri, Jun 19, 2026 at 4:32=E2=80=AFAM Xingquan Liu <b1n@b1n.io> wrote:
>
> Add a regression test for DualPI2 GSO backlog accounting when it is
> used as a child qdisc of QFQ.
>
> The test sends one UDP GSO datagram through a QFQ class with DualPI2 as
> the leaf qdisc. DualPI2 splits the skb into two segments. After the
> traffic drains, both QFQ and DualPI2 must report zero backlog and zero
> qlen.
>
> On kernels with the broken accounting, QFQ can keep a stale non-zero
> qlen after all real packets have been dequeued.
>
> Signed-off-by: Xingquan Liu <b1n@b1n.io>
> ---
>  .../tc-testing/tc-tests/qdiscs/dualpi2.json   | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.j=
son b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json
> index cd1f2ee8f354..ffd6fd5ba8f7 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json
> +    {
> +        "id": "891f",
> [...]
> +        "cmdUnderTest": "python3 -c 'import socket,struct; SOL_UDP=3Dget=
attr(socket,\"SOL_UDP\",socket.IPPROTO_UDP); UDP_SEGMENT=3Dgetattr(socket,\=
"UDP_SEGMENT\",103); s=3Dsocket.socket(socket.AF_INET,socket.SOCK_DGRAM); s=
.bind((\"10.10.10.10\",0)); p=3Db\"X\"*2400; n=3Ds.sendmsg([p],[(SOL_UDP,UD=
P_SEGMENT,struct.pack(\"=3DH\",1200))],0,(\"10.10.10.1\",9000)); raise Syst=
emExit(n !=3D len(p))'",

Can you make this a separate Python script?
Something similar to what the flower tests did [1] with tdc_batch.py [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/tree/too=
ls/testing/selftests/tc-testing/tc-tests/filters/flower.json#n205
[2] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/tree/too=
ls/testing/selftests/tc-testing/tdc_batch.py

