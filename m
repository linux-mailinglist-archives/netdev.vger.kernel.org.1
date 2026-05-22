Return-Path: <netdev+bounces-290839-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNdSIDxZEGpcWgYAu9opvQ
	(envelope-from <netdev+bounces-290839-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 15:25:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 013105B51BF
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 15:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 154FB31300BD
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7869839AD5E;
	Fri, 22 May 2026 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9A7CaI2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0026D399CEC
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 13:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779455223; cv=pass; b=Bdr2k8/n1efh7zT4viNv6rwCVMBsyeLqg8XM4+R7KqAplWai4TsUrMkgTnVjqEbk+46iEMIku36uYeCJd21ZTW0oN5v2caMyevE5nwMts3wHiJ/TtOuAENGxu3MpkrHO66U++59Eq8VxO2PrvqyGkKCJ7wCEkVv2rhlYK/v6ers=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779455223; c=relaxed/simple;
	bh=KSaEuSw5cR1Usv3Ap2kysrOBKocVC3XD7neTS3R/IPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uH0NAYNfd+cUYBx/HDSnNjdY6rYbO/FaY4TywGAYyuBQfOEd61/BgqnnfUgREtZtTaSjmUTEXjNpkFuoSMJtUDHN5CaD0hSrHcjIKXB6pWDO3A8j6v81TcqiMIkqWSgl+HdVbUZcC24udRyJZuitOf15z3gnzP9Yy2Mw7/LTHq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9A7CaI2; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ee990e8597so17729729eec.1
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 06:07:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779455221; cv=none;
        d=google.com; s=arc-20240605;
        b=J1iIrvZhEjfk5ZJM1OhyKOeQ9ylN6H2y5GBBS7O5wzreguV1BSFWMzpE3JfN4I/zhX
         TwOn3eJKFlWY0uyn9X/LVscO50Y9mx6MiB64967byuvQYC2KCkSyyUmBfWFBPQir8O0H
         VH+C1La9R9JjYrbgml7ufI7H632RjgWBmiTiUoCubSg3ZJd+m4CUtqub1TCI07aHtvOu
         m0LOufCtwG9FlDIna9Qq3WcweoawMbl8a08vJuXqlp4SsJu7E7NYNudKQJnaBegr3oqx
         7IFi6P0TK14If8RYLTuj7EydtLP2uyZNbkBUUMNzwE8SurI0p4LfOmun/95zI9dTuyZC
         QcHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CcNLzQ3SzJG6lFwMI5fOP1EQlY9tsnZa9iOPM1rLiDw=;
        fh=4l5DPsttvu+8jWOE2eSNTzjeAEY7U3uZSLa1DZhy4Po=;
        b=PIW8pJxZyEfAOH2mfpoiG5f2CRzgpTfuPKCnsRWYC4OcTNbgEvfgQ0GMde2RCpIMgG
         zBZb93nSoBRv/tkzAEbHo99H4EV5JdwGhau82626pE7tamsflwM0UJCtSfzv32quLl4w
         pfAoNcFYQR2Jscw4yOTI05ORmLlNA8tm2m7FLlIQavousNK3P1GiKEo0HKhPN0tMIiBA
         PIf19OOzhp6Eh5dFYnAVVDyMnQifNzhVOvUvGwbxMmqU1qShpG5dD0bdlSAr07YeMXhz
         /9uVYP2dVvQ5I8yl0vDop6V2M5JPNLuCGSFKNbFwtguSpmc8o+i1MQl8lOWGSbXDQ52G
         CjVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779455221; x=1780060021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcNLzQ3SzJG6lFwMI5fOP1EQlY9tsnZa9iOPM1rLiDw=;
        b=P9A7CaI22mUVV3U28lqerw1m0d4Y6HMGao9knxTwtWeqClNZR3tBoY2V7BF93+TWoo
         1lqACz5OhiiBXIAzWlg4rv+Q+J5JOOvLjzsFNFzkM7209e6dLvV9aYClRbTOmVSE3bry
         Gk3jzadmvOHSEriczW1yFwHnnhI9XrYDdUn7RLi6rxVktFIH6ne0FapXjr0WyiyLki1Y
         1MECbNmc1Yyx9gaXDROmJVwhbbhNH/9mCpwi733aWSiTGVJRb1vrNE5gx0JxjK9qBRSx
         8AO45+5XjKV6+2qP+/ibgq/HtSbFrGDyaSrvvi/H7ytGGh4a40BGiiZKgTrcg/pCoXF3
         HMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779455221; x=1780060021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CcNLzQ3SzJG6lFwMI5fOP1EQlY9tsnZa9iOPM1rLiDw=;
        b=YKAoSdnWZ4Y0YOQG8z6g9qYp9T8pR8WFfKOStDiuV+nDgehJv8ERbY7yQK6RQxEXoL
         /4ESg9x+iLULqVJqPt8ukGpAfGK9J3D09rbLiPqWbx1At+T2xoe/rCyXXzHp8dHV7hbT
         C3PK6uZN5MGbjRu91Hu4jmhY3XQXjjqNS7Ehs0J3A0H6yAJHTrmct0lzdV3zd2elaZX3
         MjnjWSnhzLHC1tbNDjAstS7LAGEooseoBuV4hNMmnVw1RiBUTZUToFfd+Myzaiusb2Z8
         etH0XB10SWJJwRF2QbAToP/I1Il2zMHLFAPm006PwZyxTz430x4L7vCE8yA99U9/3NXc
         mUCw==
X-Gm-Message-State: AOJu0Yxe75NcNvLm4zrUvno4Q6TkJpyKVik7QNOnY0HLCc07p5vhK3Tp
	N+VsU80lX2dFo27z9ssYoGE97LlPIEBLEfuxpsoRJryWgU7C2q+1wP2dG7/JA/vAHpTcBH2q+An
	L+ZLPqYBfoxkI4yONsOugQ6YVFezS42Q=
X-Gm-Gg: Acq92OHJ29+QXxfsqEWBM+7PuztmjZ9BijRhWLH4KbG4M6zSYpfJcIlHxnsFToHmmao
	ti17c/+HbTYrgfQrru83toxHmUy8jcHdNRxLz0qqCIV/jtsb4hPvwn7ZnxXVlg0wCS2BHIi706N
	L2kobZs4l6i6ySD9gdVOXZtYFG/usPvnRHk4rJ02h27ZmfbG4aYS0rgcIkILwrm6CfKKYx9r9k/
	nfRVDTMNq4oh+22TB5oR0X3Z9q71pevNr+K28TicC7LyNvV6kOdLAAiqadhnI/4l+Wh3cqAO+tq
	ZR2S
X-Received: by 2002:a05:7300:f196:b0:2e6:e504:5435 with SMTP id
 5a478bee46e88-30449001bc1mr1935099eec.12.1779455220962; Fri, 22 May 2026
 06:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522050740.84561-1-ebiggers@kernel.org>
In-Reply-To: <20260522050740.84561-1-ebiggers@kernel.org>
From: Marc Dionne <marc.c.dionne@gmail.com>
Date: Fri, 22 May 2026 10:06:49 -0300
X-Gm-Features: AVHnY4Ixi-OiYRQba9g6693g6xpVS_YTTM4oneVGXagDX2SEqWexJ-_Aw02uq-E
Message-ID: <CAB9dFduBir-41_Ef4noEJPHsFU-++JHDxMU-6S7B8pBYynvadA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/5] Consolidate FCrypt and PCBC code into net/rxrpc/
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, linux-afs@lists.infradead.org, 
	David Howells <dhowells@redhat.com>, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290839-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marccdionne@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 013105B51BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 2:07=E2=80=AFAM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> The FCrypt "block cipher" and the PCBC mode of operation are obsolete
> and insecure.  Since their only user is net/rxrpc/, they belong there,
> not in the crypto API.
>
> Therefore, this series removes these algorithms from the crypto API and
> replaces them with local implementations in net/rxrpc/.
>
> The local implementations are simpler too, as they avoid the crypto API
> boilerplate.
>
> I don't know how to test all the code in net/rxrpc/, but everything
> should still work.  I added a KUnit test for the crypto functions.
>
> Changed in v2:
>     - Added missing export of fcrypt_preparekey().
>     - Write "RxRPC crypto KUnit test" instead of "RxRPC KUnit test".
>     - Rebased onto latest net-next where decryption now happens in the
>       linear buffer rxrpc_call::rx_dec_buffer, simplifying the code.

Looks good in testing with our kafs test suite, forcing the use of
rxkad with encryption.

Feel free to add for the series:
Tested-by: Marc Dionne <marc.dionne@auristor.com>

Marc

