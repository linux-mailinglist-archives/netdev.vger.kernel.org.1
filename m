Return-Path: <netdev+bounces-263548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECdFM62Up2mqiQAAu9opvQ
	(envelope-from <netdev+bounces-263548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 03:10:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7541F9C92
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 03:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC61030528AE
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 02:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8DA25A359;
	Wed,  4 Mar 2026 02:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="psLq4C/c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF919F513
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 02:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772590213; cv=pass; b=kc4+32rlSQhK6eLJfNVF6+AuaDH4lX9Ivds0dBOze/4B09d9UYqqWWgfQngJwHNzOZAWkkk5C2RUOyLTGibiRPEsZlTFeiAfvm9/3RFs8JWpQD3faAeTq2ssM53z2QpQBBWaxI8pUd4Euto5DeRBXP72APZvsrcZX23kgp3HA2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772590213; c=relaxed/simple;
	bh=iFqGXl6hkZDQJhz/yG3pXP1EubzoZZcVech5ZrFSTDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=htaXwZU/97VsO/aCMtZWr4BQKmUit5SKaqG5RbZcCgeP8l9UvSiMBhyYpgBXAeqO2W9P+/ThT4HmziYwHmdzGxQ+i+0KDCaSJH6Hvq+Fvn0rMXa7vOssCxPg8MOLo/9XFnWZxbZ+3eCsuldojCrxLpDyrf2ryY2jYcMqBXVwB0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=psLq4C/c; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-506a355aedfso742791cf.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 18:10:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772590211; cv=none;
        d=google.com; s=arc-20240605;
        b=K/oMnspaQUh1LsvMSWBfY5zY95KuEBNyzHfgcqlqRKIn7rIY6WuIBvcQge5qjXewrp
         KTDXz9+iGaxThVEv4IA6I+cn1dWm65VuJjdCrHZ1js/iAnp4qG25TqNzIBwp6wtYIZvt
         h68IR4FXE4e2l/1ut6TFa6HcETD4fa9Ec2tBzrsNa1GewP9+sig1ae3NUuiT1A7DDk3q
         wsQDt/52YCJHHt3MLqivweSRIZ2i1ay3h3kbLlqwMQc7zdKKiRv1QHGD4pKzmBAR2Vfb
         hBLyxszCZnG51Qxpe997OsfY3Vb9D7tusV8+c76rHt52ssZHh8ZBa/3xfwOv6vOifgRP
         O9Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iFqGXl6hkZDQJhz/yG3pXP1EubzoZZcVech5ZrFSTDY=;
        fh=ioUQmgdPowOpJ0GAUChr4zlarMNf9wVU5l1vspxjDSU=;
        b=Np45veKSbrKTmAkxmj7U8+XckGlW+DuvVURbHkj+Eg0bn7VN+LeYKqraNPovwnBT8y
         QsZqCUAZxyx9Xssqz6NIxkh9EjLqLxRREjkC52pyuecyY7h9S3SoaUcUDJ40hRPvEIFH
         wUnKP8eRFNd9Q+twZg++m/fh6Zw2s4I3+xzNNrF/X5S/ZiaJFzu8H1JGtf+hWmBrn237
         cUTEro+KARJoRAvPClPuQxCVmgYCpnLllAlRoOEkvbAIaxUFG2x/+mwgX46i00YU6TR1
         WrZayQBO6dAULM9UHKZLKxjQarNGplSWY5ZhebkolzOp8D40ztII21i/z3MvEj3g5VCH
         I9Qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772590211; x=1773195011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFqGXl6hkZDQJhz/yG3pXP1EubzoZZcVech5ZrFSTDY=;
        b=psLq4C/c8VMYe9Dv1Ocb7CAOhpyOTAsq1AQC1cDz6bHoPuLWw1X0moBPC+KGLyRhIp
         VOGecd4bm81s0kvaVdStb8jAO2HxqBJvYWCyb8rbbBW+83FMowyzYmSRqa7Trq6tk5nd
         IFvJ8zqqUPkWlq3FOhZ7EC9To4DfbXOIHYSFttfLa//P9aG/evjUdYSrqKwwbWWiX1Bq
         h2/JCRNyOnh+BgNJs/ByrAiupx+fmDevl77TjyokI8A8g6U9+TtoFFt4NBKZy6nEMaSF
         XXHAs4asps8hB7aBYAAeeBsieAzExMGEWT2cPp1viqGaYvsnP289/xDesBxP3O4+Gq3N
         TVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772590211; x=1773195011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iFqGXl6hkZDQJhz/yG3pXP1EubzoZZcVech5ZrFSTDY=;
        b=OMMHOJ9qKP6wmuXEsrP+YrGfRzXUh1klWPTTCK6SmZzDnLjDt5RhFMED3ybKL9gVfw
         zy8SNaCEZlYGPXwqt6dVsTr/52EuaUgxFrUNv8V11MDy4Ms6HZ7WXSbj/0PjLixPgGMA
         Bqh7UG1joctQNgzwSNUM6Ia4N3YuYKdm8Xgs5QEaw/DEesp0U8HuPfQDmNpAS++NFNsO
         zKtHXVX4Qe38qR0+HsAkXYqT6tEvFNobWo9kBT+1BSLKeMVsWJh7juD+IgkdvePfSwjZ
         gJhtVlsoFeyu87zpG/4RPwG3+IYakeH7xYV1NUdyLV2Ryw+iETLytvss3dtJqwaRFaOj
         RYeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMiSJ4aa6Z1tzWIwfVwnAoqchh8IJ2dTWTergqI6EDb8zYumhISuKi7cNRo9nQ7+G7LrWoFfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6noHyr0eQCEJTw1OCUzY/CFIjmT1K/WrBPfMigHIX6MofvyfP
	J2wTOp1XAsDxBdZuG7VXGvWS8jNIU6rdsei7moilGKPhOE8a7AlZDdy1W7hgt0BpKi73blWCbFY
	QC1Atx1qpBmj3OH3TFSNKbdLfY47yjV1JIP/Tk6X7
X-Gm-Gg: ATEYQzxnWSfyviu9GZFfODB/d/9jtHKgeLV1nKhRrPyZgMEfoC9Ag/oghDiPlwLf3nm
	wDtnVImcHl2GJDaKivhGFZcEORB9gktwVP+IBDEhU4MMDpZmlKU1Ybpsoj7bRwgb9v+R9C1bqog
	XrzPmCI2Q/ZNFSsenURDuFMiXMq2zb41vGrhonMt3RX9V8x6CBnMDxXd/wpoEa2RsfxmE5RetAA
	C/NJ0gAjrHyp+N247V96f0yYNFinBTSXeH3fV6qgw8wgfLhQ+QXOiSGPpWv2G/Ds85S0TWbd86Y
	McNmdVyqS4jz29M70zECvqDNCOKjinDrMe5IRjpy3685cLXe/wxWNT0nMNLhA+zHgdss
X-Received: by 2002:a05:622a:106:b0:506:6ff1:fce with SMTP id
 d75a77b69052e-5075fd1d5c6mr46761801cf.2.1772590210251; Tue, 03 Mar 2026
 18:10:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304015640.961780-1-edumazet@google.com>
In-Reply-To: <20260304015640.961780-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 3 Mar 2026 18:09:53 -0800
X-Gm-Features: AaiRm522wqHqE8RyVNC1oj1WMWgAYIrDumqJG7sNsjSMcDYzUEcf_4T597YwK0I
Message-ID: <CADVnQyn30yeYsdu03Nw2037Vp=9+qY2G4yf1PSLD7JbgwoA-tA@mail.gmail.com>
Subject: Re: [PATCH net] net_sched: sch_fq: clear q->band_pkt_count[] in fq_reset()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3C7541F9C92
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-263548-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ncardwell@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 5:56=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> When/if a NIC resets, queues are deactivated by dev_deactivate_many(),
> then reactivated when the reset operation completes.
>
> fq_reset() removes all the skbs from various queues.
>
> If we do not clear q->band_pkt_count[], these counters keep growing
> and can eventually reach sch->limit, preventing new packets to be queued.
>
> Many thanks to Praveen for discovering the root cause.
>
> Fixes: 29f834aa326e ("net_sched: sch_fq: add 3 bands and WRR scheduling")
> Diagnosed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Willem de Bruijn <willemb@google.com>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric and Praveen!

neal

