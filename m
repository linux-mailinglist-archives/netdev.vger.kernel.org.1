Return-Path: <netdev+bounces-265941-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEvVOtLbr2kzdAIAu9opvQ
	(envelope-from <netdev+bounces-265941-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:52:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52455247A8C
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1639304415A
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5AB438FE6;
	Tue, 10 Mar 2026 08:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xhG3HsYM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA573D6CBC
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773132431; cv=pass; b=dHNdnWbUgrtp/2QPKrdp9hNzruI4k/5EvbWP55DeMFL7Dnt82Bif4VEWHw/nAcmLXxr/FWVH945AiCdn03xIm+GfCbTzKQUW3ijT6fEPFl1JGDVBidYiRso+k5ij4tntEBPhmO3oklRs8Itcls17cKOnQ3z2CNzI5sG3DecfXyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773132431; c=relaxed/simple;
	bh=d4ku0rUPq2W2b4nzjW/2a3G+pwxDd6NAsRFLOoSQPRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGCE0nY6MG+OfUWAqxNbngFnF+VTqMXLlJdL8AbRX4OZ4rG4cvqHQjuXVFWKL2zDQNSDtWi81mjuizVdFjWf4Z3lgJUatk1hZWP/WetrQdt7PbMmInd4vyGPObcRUw/vHU0rTn9cDEwjNQMEgR0Y3ZGjurzn/E8MHCUjUFO65uY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xhG3HsYM; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-899fc265126so118942026d6.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 01:47:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773132429; cv=none;
        d=google.com; s=arc-20240605;
        b=EBt4NWoDOfuFskTd+HsgkqHZWI4Bq/slDymteOsgVDQdVPql/Np/itF0arpCg713GV
         wnSfphdAHUtGSPUWL1HjBlbz08N9Mcfshae2xwGuioOLD/Et85CqH0FxZ0VjXPZESCAu
         J5R9EaPV1XdvoB0wkeFEWgEF7yvn635nqIuriRTKSg0ip09Hl+9lQ7mx9Km8Fq/FwZ4q
         d3RfnBPn6jvvPmiHRemjn+jGRSfvxHV8Oq86htzhm/TVtKnzRJ94qCPIOjvIlsvNzvuQ
         jO1KSdtC2j9A+5w4kSaBZ4WB7q29iMHK04NgQ29OFrBo4KYDAiO7/xjPGQ3UJPCTdavU
         tHng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S/YKfuwEjoceIF72ASHR08YC1df1DlHUUca2FdDvmBo=;
        fh=CCQBhchYyjzzwTEoIyjTdBYZhdCiwOYvXOpvNEF22zM=;
        b=Y+bI43CpcTYxMzMI+9vAumFEE0RyD3c25OsN7jj4BDwJzUQkBHz8u7UXO7GqduYbnf
         lY/gw7pMHaDw+/37UCKXflDmNvZvTVxNtPm85EwEm//Hjz5MtrKwt2XqH+vgBNL8j0Fv
         C8c3b1GJAjllWWJtp33m8xo1AZ/dqMH5Iem53SAgpkN8ACOj8FKqV4P7XaizA6Tfhdcn
         cif5NKntojpd4PS3sQERbcc+h9JkJpCR6NvKwgDrJo93wUH7biM7MwpSiF3C7cpp6fR2
         KXQBEAn6zAg3v9D9oKWClCdlge5PHx0BDFFZ0BXpsY9R0M8qucILVjA/uB+iwTHwX9Ma
         PP0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773132429; x=1773737229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/YKfuwEjoceIF72ASHR08YC1df1DlHUUca2FdDvmBo=;
        b=xhG3HsYMI7RPs8xQO/lrS9Jo+wVenz1cbTuAppsQF9yNtLQwfaKo6LALa6Dmau2hvq
         cy5hg+0U4K3XzQZN8IhobA/DeG7gHcD7BptrHZAxtVR+SkZdauq/l4oLFEHau+lQix5H
         A01Y/s/6xdR1GU6s+KWMMuNF13bmRBzgtoS2fTIn3LuSC4HKTk+fMxfYBRHzMMZ94ngN
         wDnD5QWU/Te+JBTDi+ph0ibrm3gLLzN7gmYbNx7hy7icxVuQXmKqF7zr70vEEpUCRAti
         sQd9g//3Jg0EGGSClCHJtJ0C09bjjv+Vguz7N2IsbfzW5FISlO8sAAQQkZStVaHcTk6P
         WpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773132429; x=1773737229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S/YKfuwEjoceIF72ASHR08YC1df1DlHUUca2FdDvmBo=;
        b=rU1Qm2mtuPfsgtEurKNi8Q7Un/mIZn2OwteXgPi0Xw52Q2nVerRcwbwaysnm1o4Xyz
         BsMxiqVUnrYBF0luBx4aXBaxX4PlxaMLxiBXvxQYsMUoSJ+/hzJhlQ/wA3iHir4GVBtr
         9MhKKUFAk0uq0bhx7G9h1a4thN4q5es1fZkNtLwG2MOwjZy/hlwbr6X5Mmvvw3jzUgGP
         httqy+fgqKTrPzLnddmLmOdJ5pBJon2Bg/59k5DYyoxbsn16oTfFdMr+hqUtRGd2QObZ
         EbZMNqsQ9l6JoFaqqMoYNGTzH6g2WBFHImKFdPjeLx7JR4VhKLzefWjbUtoNzcNJAGOf
         1hIw==
X-Forwarded-Encrypted: i=1; AJvYcCW/B6VRjViXD+UObdZJ1JDH4lxfzJaUhoTPhKsU1ah1Z6NOq7jvG52W+nflwOO324plItCwDeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz3N6SspBHtBL6FQJfwG23gzqnA4muKKhuxCvekw5QW6+YL6F6
	XQtv7qeItEy3gbjfVYOmiHsNbYWuIelPa7gv1URGuioA6vjOK2GZJpMNS/7O4qrHcXYKAoJHf/0
	TMMm/UDef1hZlXV2UEwMNdgazJUMQxRE6zy5vS8ny
X-Gm-Gg: ATEYQzy3pb4NSBKtjCjUUwDruOrcb6ZntPV/t8dx/vWJys/JZMoZWoK0ns4ncDBJ3xo
	z/1Gl9P7H9Izji9ngIrTKzeMdeyvzaMPXxSeyC5dxvw+bwT82qVbK5BSyY0+XVUfPtcLkw3kjJa
	4xzMIxiWPut9+1SfnxWIdNZPH5RDEEt3KPbvJ2T21le2jVhKMO9aSFSsrrwuy34hPslWYOzaeGB
	QO7azdovl2O5m7IzTj8dDCsgMp8b2KVVsQCaE24NN5f+X6clDSGn1cBm+cOn3nSd3E7yf1LdyPN
	FK+B1Kk=
X-Received: by 2002:ad4:5fcb:0:b0:89a:13a5:77c4 with SMTP id
 6a1803df08f44-89a30a809dbmr212994566d6.29.1773132428381; Tue, 10 Mar 2026
 01:47:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com> <20260309-tcp_rfc7323_retract_wnd_rfc-v3-4-4c7f96b1ec69@gmail.com>
In-Reply-To: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-4-4c7f96b1ec69@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Mar 2026 09:46:57 +0100
X-Gm-Features: AaiRm515yCYx-zywRXphow2t71Syn2XmFVDbg53R2r2K3-5MlWrmIcf8VHqN2p8
Message-ID: <CANn89iLrpBui8OGtPTV+Vkane7xHNErPB8a3AgOEawpi7CLU3g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/6] selftests/net: packetdrill: add tcp_rcv_wnd_shrink_nomem.pkt
To: gmbnomis@gmail.com
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, David Ahern <dsahern@kernel.org>, 
	Jon Maloy <jmaloy@redhat.com>, Jason Xing <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com, 
	Shuah Khan <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 52455247A8C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-265941-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,cloudflare.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 9:03=E2=80=AFAM Simon Baatz via B4 Relay
<devnull+gmbnomis.gmail.com@kernel.org> wrote:
>
> From: Simon Baatz <gmbnomis@gmail.com>
>
> This test verifies
> - the sequence number checks using the maximum advertised window
>   sequence number and
> - the logic for handling received data in tcp_data_queue()
>
> for the cases:
>
> 1. The window is reduced to zero because of memory
>
> 2. The window grows again but still does not reach the originally
>    advertised window
>
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

> +// Ooo partial segment, in adv. window -> accept
> +   +0 < P. 1040001:1042001(2000) ack 2001 win 257
> +   +0 > .  2001:2001(0) ack 1042001 <nop,nop,sack 1040001:1041001>
> +
> +// Ooo segment, in max adv. window, beyond adv. window -> drop (SKB_DROP=
_REASON_TCP_OVERWINDOW)
> +   +0 < P. 1105001:1106001(1000) ack 2001 win 257
> +   +0 > .  2001:2001(0) ack 1042001
> +// Ooo segment, beyond max adv. window, beyond adv. window -> drop (SKB_=
DROP_REASON_TCP_INVALID_SEQUENCE)
> +   +0 < P. 2000001:2001001(1000) ack 2001 win 257
> +   +0 > .  2001:2001(0) ack 1042001
> +// Check LINUX_MIB_BEYOND_WINDOW has been incremented twice
> +   +0 `nstat -s | grep TcpExtBeyondWindow | grep -q " 4 "`
> +
> +// We are allowed to go beyond the window and buffer with one packet
> +   +0 < P. 1042001:1062001(20000) ack 2001 win 257
> +    * > .  2001:2001(0) ack 1062001
> +   +0 < P. 1062001:1082001(20000) ack 2001 win 257
> +    * > .  2001:2001(0) ack 1082001 win 0
> +
> +// But not more: In order segment, in max adv. window -> drop (SKB_DROP_=
REASON_TCP_ZEROWINDOW)
> +   +0 < P. 1082001:1083001(1000) ack 2001 win 257
> +    * > .  2001:2001(0) ack 1082001
> +// Check LINUX_MIB_TCPZEROWINDOWDROP has been incremented again
> +   +0 `nstat -s | grep TcpExtTCPZeroWindowDrop| grep -q " 3 "`
>
> --
> 2.53.0
>
>

