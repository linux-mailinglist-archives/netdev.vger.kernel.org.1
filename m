Return-Path: <netdev+bounces-257636-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JslHScohmmLKAQAu9opvQ
	(envelope-from <netdev+bounces-257636-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 18:43:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D441013F7
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 18:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1078303DD06
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 17:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2393A3F23C3;
	Fri,  6 Feb 2026 17:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3MXZ1z+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C572A363C65
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770399570; cv=pass; b=iV9ObFU5mAGjqRhzvDQZkRuqE5t0XP2HBzTgiD4cVN+nbSQb/J6GLi12eFKm6HtVB7qlt7+WmrJTFCkgzVvLl2LVbeIY1cVqHK81+S/u7OYb7njzHcGsP7JtRn7eM0K3USSZVXbPzTGPVQTpJtHvVGEYSw/kNLPUrT7IKZ1ID8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770399570; c=relaxed/simple;
	bh=/xcM8rEuq6wU1HRmAP2pZXXwStrfQwI5eVL19g3QaqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJUYs30UXthKRAq+WP+y/imDvA0FwMIUlnCwHELXwf4t0/9Bvv3/DVd2HW2Fhvz2Ar80JbfDiNF9q63Fh1mufU5snbJ6CCmoqfMnbNfZHtfJueCORINJ/towahrOTTgT6z3pdXOMlrAWTERonT7x0ityn4A42XLKk73cfRk+XOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3MXZ1z+; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso21566455e9.0
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 09:39:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770399568; cv=none;
        d=google.com; s=arc-20240605;
        b=gClZHTAZSxG04vUCCM1txg7NTrTWUkrGbff+HrW9sVZ5Ixgk3LaCoRynfxMAGgAKzP
         /MEAxqF7gUmpSSIRoATgvTJgh4UgrDv2AlsO7Kz5wnaiCZhvl2UHqWg1sotWnebZnyhG
         HT1XVSDknTFIf+iQjW/UXxYE6Ob1y3ndrzjWYLKEMvnz42pqy5eP3LUWHcqMu/Utt+4x
         EMippVPP/wfDyi7kH/GyvUXXAE8XL27ruLnk/5S4ZpgSDEXMPgemPseyHvhJ77E6BaOr
         QyU7s9X/2thOwOXYizLC1WkMErZ24cUiOjrW/L6fzf1hWtV/ZghIBoLulXzpdEzSpC9a
         XsUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mxsEHElmdVyhBy8oLH1GXCMKsnKp6WZzm6RxnoWSNrk=;
        fh=rSOL8PANxY5gSoaFKGUFuVcWg1euIYI+JIVYItgfvzY=;
        b=Sy8XVMOX82pHFKcq9Cp+KL/dJ9WIMZ5ed2c/ga1ieTj3lJnwWPCLwSAz2J/sg+sdIo
         cz9qhK0D47Ksyd5tOYHX1sp9P7knKkUYZbUoihGT+s5/r+XEmFm4TQPp9Gk29QP82loB
         uKCd66Tb/SxeaWE8OqalzN4z39TEsP6jU0i3U1PC2CJRlMyU+fIAiaUaaY8XyiH5b5Jj
         nBJvC7K2NHCxI27+m1To8n+Dc8rbg4SHP8NTqtOE4W3wLnKsagMgghLrlj47vPPv0vQr
         NMkFm59H5t2XVKDSHuJc9yJKu5yLip3IxZcXEJptIxKt2+8Z1hcbGdGB8qJ6bSPwl8GN
         4zJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770399568; x=1771004368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxsEHElmdVyhBy8oLH1GXCMKsnKp6WZzm6RxnoWSNrk=;
        b=A3MXZ1z+QIIwhKGNQ08W7aQoPinyGSMRGyC2ISaAv1LWAWuFGJEXCEoXBg/6SdGObK
         fKcM/Dd8qcm7+7VyyI8bNn8QWfe0uKVLZRzGxMneej/JEN2bqIm1zFCbDRtCFYt/qAGH
         lpxseLVXotWO+fksTgbG+IBmA3nZDmPFPZRylMIIn01u/Hq3rVQG2cMrmTytn1RT56vb
         8l5qSeOgHtxWl2WwsjXDkGmZlTUNm3TajcTP1f67j1clb18brqZ6mnk2KHwTPKcrbcTd
         FBuFHH1sV1Can/KH6GiCwREqr1kkwePWLzgkmBNXI/qu7jFMW/fc2o8EIux0f/XvOuw/
         0xEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770399568; x=1771004368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mxsEHElmdVyhBy8oLH1GXCMKsnKp6WZzm6RxnoWSNrk=;
        b=cluVMqWhHeKtTkzZuotzKyw1kQu23ITzrfAgb3HwPSfLcPBA0ZwfMp0/ApXLcp/Giz
         xpGhh3+SiR4FgS1E7nMjafE9T7KAt3GIJLwEwW8zrlYC2O8yPjCZ3ThyjycoUg6y9TKN
         I4xOdUhTxaiCZXe8bOdCaWpzAqxqSSHIz+MuVWxD0WWlwa/mUI8G2IEC/SIunTPq9jy3
         SPQvumBof4bqJEIBz2Y3Nr8dBFJRVboOgsKNiFvWfzXYcZ2bq6V2u7/QFAxpWvTLy+Jx
         l53I/NVmXG20E8afDGKOf1MeDG+0llsfOSfJCXh3zcivSa8iFT3nP5IEEv+fZqkikkzN
         z+bA==
X-Forwarded-Encrypted: i=1; AJvYcCWXq9hqXpDLS82GmFFVx2lY+cHI+aEX6u/W8NthRvtBJSBfIyYEi3slBfxt75Pw22H8Ur4Fjbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBgtphFiIaDnS2NxspAjd3xVYNy5n5Zu3+4h5agj53no+gb6Ze
	EEuNXytbTvI4sUVweVf3DlZjmoXMJjE2raX3TkVSfz2sjleRdqMBBcGvCG/GcBnbX3ueIZH2bx/
	cBDR1uDVPKoN4QXaGCzKDz1QnQZ37MAQ=
X-Gm-Gg: AZuq6aJP8G2uOdPf6HAKiZ5x9NVBM0oGf4IgAa/yNtSJNnSE0cGVo4+zQEvOM+IY812
	7qvSGcx1Zjzr4qvWla4cXZ8jGE1qvpoQtRVNlOV3fEoMxEH8oer3nifqkCTLf3jh3WHTn5nC5W4
	fQ8hS9P9a6FXHkTLVUXizfJJDE6+u9KNcSJOduOKzROmjz5tFEXt17jaQcU9zBGyCKpeUFHQWm9
	UNFxDPKvJYwrJsl0NccEIgzglpfgwJ8rE60RhIKomDf3PKFW+5WsNgx5W3evogMqFRmLOpE1nih
	PUcWCUOAUPLMOTYfw66BOrmyPkxRCy4OVy1dXLeNzvaOYljjqU377fSIhnxJ32oeBtg346B7mJG
	swkwayiIvpCmN2g==
X-Received: by 2002:a05:600c:6209:b0:480:690e:f14a with SMTP id
 5b1f17b1804b1-483201ee840mr48075395e9.14.1770399567976; Fri, 06 Feb 2026
 09:39:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203155103.2305816-1-larysa.zaremba@intel.com>
In-Reply-To: <20260203155103.2305816-1-larysa.zaremba@intel.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Feb 2026 09:39:16 -0800
X-Gm-Features: AZwV_Qhiudu9I4yt9_TPQJS3OSxaKo3Vh7XUGlL9nFcebbE8dzWA0vJPdWwRON4
Message-ID: <CAADnVQLszbJ=dMjmAVkj1zGBPhhopU7XHH6bc1UHEemXwbgxzQ@mail.gmail.com>
Subject: Re: [PATCH bpf 0/2] Fix some corner cases in xskxceiver
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	"Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
	Tushar Vyavahare <tushar.vyavahare@intel.com>, =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>, 
	Jason Xing <kernelxing@tencent.com>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257636-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,iogearbox.net,linux.dev,fomichev.me,google.com,davemloft.net,intel.com,bootlin.com,suse.com,tencent.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,test_xsk.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 14D441013F7
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 8:18=E2=80=AFAM Larysa Zaremba <larysa.zaremba@intel=
.com> wrote:
>
> While working on XDP and AF_XDP support for ixgbevf driver,
> I came across two distinct problems that caused tests to fail
> when they shouldn't have.

Applied.

What is the status of kernel side fixes?

Running test_xsk.sh I see plenty of

[   93.609026] BUG: Bad page state in process xskxceiver  pfn:115920
...
[   93.633927]  bad_page.cold+0xd0/0x140
[   93.633929]  __free_frozen_pages+0x85a/0x1150
[   93.633935]  bpf_xdp_adjust_tail+0x808/0x1120

