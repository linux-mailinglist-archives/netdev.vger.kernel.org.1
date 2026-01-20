Return-Path: <netdev+bounces-251605-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNmrGkvzb2m+UQAAu9opvQ
	(envelope-from <netdev+bounces-251605-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 22:27:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB4F4C3DB
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 22:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A6E2A20C0D
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E560F466B46;
	Tue, 20 Jan 2026 19:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ERoCygH3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB6647CC73
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 19:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768937745; cv=pass; b=GMt96cNS5lSaD12/3cS3xt4ArmI1AKQroiE+dhr+NfHu1TjlmybtFRlOeoI4YnziHzaP+AtIFAUgZZNjIWVBYR0ruDhM/1oR5BQuQqLARzciz794jMYEZUMSQcpzMsR8qUNuSUURO6WfdUga632s3q75pABloKlE/yhtJw2f+M8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768937745; c=relaxed/simple;
	bh=WF1YekMK7Vrv0H+TF4xGFci8W9+NmGzjNHWUBOBXXGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=izwxDegtcVPiQF1zooo1jJufuj5dRa/SAD/MLADYq9eJCF/X0QfAo8MaSO8hh8zxOsDgxBt9axMxpplmo1qev4u/MwlPESwJfCnwJ40nGoP/XVBacbAn4cKiGHVaOxcp2HmXsK1PVS1hDb8RKCs87DsLHAZzAUQE6ReKtbpjb3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ERoCygH3; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-501511aa012so69041cf.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 11:35:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768937742; cv=none;
        d=google.com; s=arc-20240605;
        b=HZcsl156cs2dKr5wtIH3co5P8vj0TOXMVgsIdl8DXz6RE/cHk918o11ySEkThqvI+8
         0IgIW8yM0wXpW0IRyApYGnk8rVDb71L57QWPMRArIzkjRJanhDE8RIOe+/0WO6V1vV1n
         M8G1pwc6rtHa0ijTJ261Vk9HgTEvps/Xip8FeSRu0QNrljwvGt07MSAM/Q5dUVmJ15Fr
         YbTFJGDKjSUNS6vtpmelLklCjumS2kONajqpQ7WhAx4gswVeNN/0dpEI1OEqWzP3oXoT
         Dq73ZPnXozQbqDWG7CxKSMxwG65VsTXyLXzFmH21tVfAPZ7BKKdK+jlxiJ8NtHIlmOuF
         AMRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e/JLh5ORNBH9Tuc6LhtRVdmaDdTnbVj6AxCAFCa2LO8=;
        fh=Cgrb4PlWZ4P/NMa7rhh3o6th7BiZYAp5tTmPQigw91U=;
        b=ODv9uwH3U/gp5pqdwH+ZXNuxGLSW0qx0KrnJnBJSlieWgzIShxIIvw8twc9CqsatRN
         yyFm32ImNK20cTzkjFZw0AFS45aqWEo3OpumSAGcKWG/gVmgNbxvt2pD5HrBoGbtZVJn
         BYQJ5f5oRC9SkoHAKux8GqRa8MWssmNvzOYVGgerOap+qj0po7+JaoF51TUcquhFbZWY
         pzEK5QpDgKxLqFP9KBuKAHa2zDjcmRdY4t+qPdJoeMib4qScM0EjpxMU4VqatKNf3h90
         VuGfe+QXZ+RzTg8Q4Oz9jb296LeUws/EbKk/W24miaghG2qs1QZNpajjWObSS7XgWVxl
         ysmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768937742; x=1769542542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/JLh5ORNBH9Tuc6LhtRVdmaDdTnbVj6AxCAFCa2LO8=;
        b=ERoCygH3AcFxMxPwYGTkGZTbXZDhlgxcMEbmwm4PJpAJzPZ2jOhEMIfvhAoifDxQKJ
         JnQ852p7Byo1BQvVA/vhZgpKJaTmogDGXL+apt357qHp5BQ78ffFdxn6ZcvGdpfPNxeM
         fa4/56gIhjfaJmYJGGmUmMqIZxpV3vaXgv239ZfseDJfbx7TLXvFG7JuMw4QJK1ooyfF
         PORPIbcTiP763DY5PsqoBNmll2/YBizkCEh1HLiNNYe+WX15TB87NdRq/F0wWTDWCX17
         aB7Zagw9HuV2iUGBnTAPh5N+L+5gzJE0ao/csczIiPQcz/+qINWAC5iZg8Ec62KcO224
         +F0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768937742; x=1769542542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e/JLh5ORNBH9Tuc6LhtRVdmaDdTnbVj6AxCAFCa2LO8=;
        b=an6264gLMhQ60oF140qbUZWkQjm/GzNDCoWbaZjhrWbEd2k9IRb/P+5ZYrHnfe+mj8
         r7x8iBbGAIkLXHdqbcu5ofQTu2CrIWcXv3jR4Vmjq7kMERKtN2WebVYEmS8P04U7zaX3
         MTgsuQP1FPatUTbjbVzayPLe9o+UM5l1qYOhCULwNgfa4YEsuPi9tRsdhaBV9wRNxYQ1
         9yDhzCtcw1S7CGydDQP3t2uy+SgKeEc5WvypXRcKj3S4ayZ0iVAPrvB1tdBi5RZZlVDj
         SU41MSHLqn98DX/S/Vx9EdDKEJkcYFq2VTsW8d3q68gOaPYkybXMscnt2bfcorro/vHt
         4aeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYb6pxjOUlC2QT99EJqPiqM5dvsM4jy1Q9LaThZSbTUDiBZdY6Ii7sDpTF5dmee34QvqA4KuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkEmaczWVfa9p2Iv8Zp+GRHFavxYYPMtJnQMexz+F0QCX5+AeS
	LsWqviZxVnN/XJcgeNFyT6qRNT5c25Q43ch5pLqFUZLvtrpjhH2caGtrY2in/nUVknKjNx5IhlD
	/sV5SlmQ7jGSl3jdNp4AyOjVg3o3Z20ytm2xLmF4w
X-Gm-Gg: AY/fxX508PneSKxdAiUXp8UpSmfgOv2AEWxTDt0orrIS/mx5BfnJXdbPtOQbraJipbF
	mrm88vwlGJYCxzGUBhqLXylKjO9b+W5GwEiAdudXTkAiNhjCqXYyJAMKv55FCGfAbxaUdci4wN4
	6mPqGGDl/O+NXUAmzzcWRvHnPk/MlgTpcyNAvwhN/zMHuh8nkLj/gan+bMM1ZYu3cady/L6oo2E
	/OXjfb4DXQfyI2ezsjj0icKd8v2Ph6WXQWLlxr1CznfU734bXZkh6lSCpR29NDK4IcW8JK6ZXcf
	g1lDxYe261Cwt0miWdqJrtDT3fWnF30vx839tCbIWXwi1w8O+Dzq2lzn4BM=
X-Received: by 2002:ac8:5d0f:0:b0:4ed:ff79:e679 with SMTP id
 d75a77b69052e-502e0cee0e6mr1190331cf.19.1768937741836; Tue, 20 Jan 2026
 11:35:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
 <20260119185852.11168-16-chia-yu.chang@nokia-bell-labs.com> <20260120105352.423ea3cd@kernel.org>
In-Reply-To: <20260120105352.423ea3cd@kernel.org>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 20 Jan 2026 14:35:24 -0500
X-Gm-Features: AZwV_QhVrFxVPZIRT7nXwat9WAQ6ye9fzegNqePUSTW1gnZC3HPe2JXn7dKWhYk
Message-ID: <CADVnQykJZhYQZMtqg+Cm4BnuVeaBjPi+VWseNK+K7Y4eZRq_-w@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 15/15] selftests/net: packetdrill: add TCP
 Accurate ECN cases
To: Jakub Kicinski <kuba@kernel.org>
Cc: chia-yu.chang@nokia-bell-labs.com, pabeni@redhat.com, edumazet@google.com, 
	parav@nvidia.com, linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org, 
	dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, andrew+netdev@lunn.ch, donald.hunter@gmail.com, 
	ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, ij@kernel.org, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251605-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[nokia-bell-labs.com,redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ncardwell@google.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid,nokia-bell-labs.com:email]
X-Rspamd-Queue-Id: CBB4F4C3DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 1:53=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 19 Jan 2026 19:58:52 +0100 chia-yu.chang@nokia-bell-labs.com
> wrote:
> > Linux Accurate ECN test sets using ACE counters and AccECN options to
> > cover several scenarios: Connection teardown, different ACK conditions,
> > counter wrapping, SACK space grabbing, fallback schemes, negotiation
> > retransmission/reorder/loss, AccECN option drop/loss, different
> > handshake reflectors, data with marking, and different sysctl values.
>
> Thank you for closing the packetdrill side, and big thanks to Neal
> for prioritizing getting it reviewed and merged!
>
> I updated the packetdrill build in netdev CI and looks like one of
> the cases is flaking a little. Since it looks like you'll have to
> respin, please try to fix:
>
> # 1..2
> # tcp_accecn_client_accecn_options_lost.pkt:32: error handling packet: ti=
ming error: expected outbound packet in relative time range +0.020000~+0.50=
0000 sec but happened at +0.015816 sec
> # script packet:  0.181936 .5 1:1013(1012) ack 1 <ECN e1b 1 ceb 0 e0b 1,n=
op>
> # actual packet:  0.177752 .EA 1:1013(1012) ack 1 win 1050 <ECN e1b 1 ceb=
 0 e0b 1,nop>
> # not ok 1 ipv4
> # tcp_accecn_client_accecn_options_lost.pkt:32: error handling packet: ti=
ming error: expected outbound packet in relative time range +0.020000~+0.50=
0000 sec but happened at +0.015800 sec
> # script packet:  0.181952 .5 1:1013(1012) ack 1 <ECN e1b 1 ceb 0 e0b 1,n=
op>
> # actual packet:  0.177752 .EA 1:1013(1012) ack 1 win 1050 <ECN e1b 1 ceb=
 0 e0b 1,nop>
> # not ok 2 ipv6
> # # Totals: pass:0 fail:2 xfail:0 xpass:0 skip:0 error:0
>
> https://netdev-ctrl.bots.linux.dev/logs/vmksft/packetdrill/results/482201=
/115-tcp-accecn-client-accecn-options-lost-pkt/stdout

Probably this is happening because the SRTT is around 56ms:

.050 * 7/8 + 1/8 * .1 =3D .05625 sec

So the RACK fast recovery starts afte rabout 15ms due to .25 * srtt
being about 14ms:
(.050 * 7/8 + 1/8 * .1) * .25 =3D .0140625 sec

If we make the SRTT 100ms then the fast retransmit should be around:

(.1 * 7/8 + 1/8 * .1) * .25 =3D .025 sec

So I'd suggest changing the timing of the SYNACK from 50ms to 100ms:

old:
+0.05 < [ect0] SW. 0:0(0) ack 1 win 32767 <mss 1024,ECN e0b 1 ceb 0
e1b 1,nop,nop,nop,sackOK,nop,wscale 8>

new:
+.1 < [ect0] SW. 0:0(0) ack 1 win 32767 <mss 1024,ECN e0b 1 ceb 0 e1b
1,nop,nop,nop,sackOK,nop,wscale 8>

neal

