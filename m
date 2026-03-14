Return-Path: <netdev+bounces-267726-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kErXEUpNtWmzywAAu9opvQ
	(envelope-from <netdev+bounces-267726-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 12:58:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAC128CF5E
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 12:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 984BA30080A9
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 11:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9344266565;
	Sat, 14 Mar 2026 11:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TeWLIwp+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B88A273F9
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 11:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773489475; cv=pass; b=rCjpMs9hKsY7llRUMTYmF0dmsA/DNO7J3o4lsCUbudTZLY1ZB6xd9U2hHSnWFU3rxfw7WNmdmpdOdOaS2szOHGS4kqOgjCSQ1njLLSiM67v8phHZ02mA/whIQBXszTyyt8F1yVJu6yycM/ek2ymmANTF8n0w81RcLRjqk7NpKi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773489475; c=relaxed/simple;
	bh=OW9aYDUHqDNvd8VA2Tq50VtG+Aet6SBNhPrGUF4ZsMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rTPDIIYDmtMZAogMq1f4MvRJezsc1H4yQ0t+VX+n435CfK0YjUJpiyn1CnY7rlsGGhbt3iFsjpVrfPWk8whBPoGGGNzw/FokxNXtLT9xcHSuVB904soXhmULXyzF54qtbVbZ6o2OCAjvbkB50rpYgnptSiXcgPpgWXyhh4E5V0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TeWLIwp+; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-899fb030812so44421606d6.2
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 04:57:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773489473; cv=none;
        d=google.com; s=arc-20240605;
        b=WemtaE/54E/Z4bw5BU4u05OeoNvUF9TPL5Q3KZud999iGwcYi+f/FH+sTEuEz4JXCW
         OwkKbiIS8FkZZt6mZpyojLApieQ/fRaFaWjdqRTwhSsBI5sGoGg+VNsGSEv3be2pkGiA
         T8ryrEjSRFzdYgpjKdcf9FuZPNJaSMlgXiDJ9rTvOZ+R3DFCeJ5WtSfv+fwWCjPNaxPS
         zsAGHVXdy7L0eRCShPIrIqy1nFHz+f9icWj4D8WLepxcY/MaIgi//GN7+EVq2FLNcANS
         Id8fYhWe48Wu2X40aZ5JvmjeVv74owIxMIRl4KHgutbcI25dCjAlICh0q7wFIDoDtdxA
         9nhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qd9UVSHR2YNCgHln1HD1wnyOz87k2sQacYjdd2GJs5Q=;
        fh=29bbWsD+MbT6OFxfz0zZZCvVLyomyAxdKQ3BPqMrVgw=;
        b=MNpdlcOYG86TNuxKV0kb5EtR5fFNrOXQwIKJ8Twvt4W2h+6F3VnXr8wscXyHyUddvC
         +DN+Sk0VWof+UyCg8wDukD/YYxPBR1jOwh3M9DT9wAJIsBwRAZOiiqjZ+x5BWI6HuDgk
         Nc/rrWkvlOu1YahU8QOoV8+m0/Xq13ySZd1adMejL0m9Z4QhKItFHr788N3ZDTo+aPTl
         QtbnQNdHCom3Rkn/KWHYogUS4osKTqGXvX892aQJj053DK26yrdenC1FtuLTJTmlNPCR
         Qp0Go7M8w/0d86I6C3TV1pJjGtl1g3vx6kZsEErC7TTUR5UgWQw/5IpT4E1744OUuL3w
         wIJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773489473; x=1774094273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qd9UVSHR2YNCgHln1HD1wnyOz87k2sQacYjdd2GJs5Q=;
        b=TeWLIwp+PUPaLr1ubPjTtW8bTddYIyOCIAWxGlBexp17bRFasl5D7z8odQ2p7wnu1S
         /OMB5rUuWB/ptICPb2cmW3PYKul6W654u1eOokN7Y93IwyCSb3xCxahjVa2XP8ImbwAc
         qDJpkCSqXCgTbIQW4I07yPJdMVh5PsMU3TpJWnr8Mei6wSoNhDhj/i1L8BYRaDoEygvQ
         I5C9HiD5dThSLQuBXRip/xUnfaDfOshNojCgJefGjP1y0R/dRNQPh3TTsnMxk0ALIRYo
         ccbAwtPYHd783kDrebYN2v9+TBPMIY39DpY0MKN7Qgdi56V/T7riQr2aq6eE8IKlItlN
         E2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773489473; x=1774094273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qd9UVSHR2YNCgHln1HD1wnyOz87k2sQacYjdd2GJs5Q=;
        b=AFqx9l1ynFPI45VesrJmC1XYADsTBn6jkzsQevuSwBJnJDea5/AoqWL8uqevNNiPBK
         xnnlDikx7otf98MEDbZQU9I65hO9iYgjA6GtoUa/PPv0TWGx59HFJDa6E0oS0HfG16wH
         r6xgqm1i+Ptnt3Vd0BgVSljW7mANNMXCPbFtVBUkkOwiA3KkOrsDA8BaMeoqARUpsixm
         aq0Ph/MAnA+bX9xFNDaiMFjbBTL/97r/x67zIdRVbCC2mN5ubV38CF2qThRnULICqpHW
         ZH89qydjN8iOUn6n99iFbk95T7NQaaolBN7qIlgp1HQVNAfDfddV7BDP4zSiUQtw1ypo
         lGEg==
X-Gm-Message-State: AOJu0YyCEeWSr0GTDDxDzYdRY/SUMAsRIGQAIZgc5hJXefI5sMGln2ED
	MOcAys5uCM7DCXFJOtKbrjd8itEVNhlO+7M4rR7BYhauCyQF4SyQslKzAiqWKk4QMTOM7Z7rsBf
	QlW/86r5lNxh219woGohKVD6q3KDweivoLoNf7a+k
X-Gm-Gg: ATEYQzx2Bcf4roQBO7cK9r+n3OaqTWik7gukmISSj+i37+zt7Tf1br7079I7IRFXSMV
	j6NrbyiTpJj4lxlfdqJihorxcypHfyUIMnOeK4NjU0wtLQannVdtItd7El+lW6uli8oK5eYYDxj
	3DzGnyQcqzDnKARoGS681TnRRK02IVqpPmtEVFAQDpis9fC32YEY9JxKYSnxHEaEC9ksgnocHpt
	7LEXWx5+Wv+R8bNky4eoX8qFifVBz94Qr9cxmTuaGLuyaRXsEPTFx9Ya8Kdf+9eEuJ5W6M29Jux
	ZbSXP/kksW7Ur4xK3Q==
X-Received: by 2002:ac8:57c5:0:b0:509:1579:7c38 with SMTP id
 d75a77b69052e-50957e23220mr72788531cf.35.1773489472997; Sat, 14 Mar 2026
 04:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260314062306.212765-1-jiayuan.chen@linux.dev>
 <CANn89iJR9bjtoZGsybdpX6T4rg1+kzXL0qV00Bs_Fiduf_+2zw@mail.gmail.com>
 <CANn89iJwZfWtGrQw+hA9DumTuYKZm5MLh8O7nkz9mPCHHazUWw@mail.gmail.com>
 <bacc7c58-b6d5-4566-bd6a-b83a2a25c596@linux.dev> <CANn89iLp8eaAj4Qtu4dvGeh9zEw+aQFe=n2dMd-zs4n-cjV4QQ@mail.gmail.com>
 <d2f9bd52-f570-441b-b3aa-570cc7f37d0c@linux.dev> <CANn89iK2EURqsjtd=OVP4awYTJHGcR-UU-V9WovpWR1Z3f03oQ@mail.gmail.com>
In-Reply-To: <CANn89iK2EURqsjtd=OVP4awYTJHGcR-UU-V9WovpWR1Z3f03oQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 14 Mar 2026 12:57:41 +0100
X-Gm-Features: AaiRm509CQHtnc0ysljixpGYUdyCaDXa1yg9jyJWFZr-KtP3MMBPFSp6QQR9xSc
Message-ID: <CANn89iLWzBknW8qt46oJw0rWsixT6-8VO=94oh7ew4C-kp5hYQ@mail.gmail.com>
Subject: Re: [PATCH net v1] team: fix header_ops type confusion with
 non-Ethernet ports
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>, 
	syzbot+3d8bc31c45e11450f24c@syzkaller.appspotmail.com, 
	Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267726-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,3d8bc31c45e11450f24c];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Queue-Id: 5BAC128CF5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 12:53=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Sat, Mar 14, 2026 at 12:51=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux=
.dev> wrote:
> >
> > Thanks for the quick patch.
> >
> > I also verified it fixes the recursion issue after modifying all signat=
ures.
>
> Could you turn your test in an official patch for  tools/testing/selftest=
s ?
>
> Thanks !

Fix sent for review :
https://lore.kernel.org/netdev/20260314115650.3646361-1-edumazet@google.com=
/T/#u

