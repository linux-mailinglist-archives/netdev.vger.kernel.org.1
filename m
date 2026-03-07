Return-Path: <netdev+bounces-265185-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NJ9M+qXrGlarAEAu9opvQ
	(envelope-from <netdev+bounces-265185-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 22:26:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B68522DB13
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 22:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9D80301C88B
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 21:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57832345CAB;
	Sat,  7 Mar 2026 21:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="PSifYJS6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325232D9499
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 21:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772918760; cv=pass; b=T6bnm4r4u4YGit/d6TUtp8FDRiXbq10NSrVxEzOlriFGUHWEdvXIiJoMs26QeRE+AUP49VvRAcsiYkNUfwkKjU6RQc21MxNbRthXl0o7ucGwJxWtGPt9TD1lD0b9WEM8nKdWcz62+4pZ2LnpKSSgOruRlnEX2d4fiyXenpRx/vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772918760; c=relaxed/simple;
	bh=PRQLBx/RLPDriKRe7fmZpdUli+5tZoupcNSox3pcsa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lH6G7C0Qbx+xcYuqpkiUh/c44eazMJE66Gik3MU6aUT/qQ9nZ1sGl2hC4tz0pecJpyMr888EXJVu7MAzEVadZ2qCAvRdbHT4icYbEGrPZsjbE/vu38zZxn0l/cmgfSQ3+7dKLMpFWVFHzwq2Qdldx5ZEq77M9+9F1LfAmIrSW+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=PSifYJS6; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-829b2019b39so572173b3a.3
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 13:25:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772918758; cv=none;
        d=google.com; s=arc-20240605;
        b=EbuSSe0iRvU+DbrHQVC5BPdwT9PytRKrAVGYZUSTwnT8omB/NBn8KHA8kmRIRerJ1S
         dfbYG620HDclLIRb6eVyxMyyFcis+58SZwKBT+7PHkM1WEu9JFbXfZdJR2sZbC6tnwTY
         VGIJd1lD+Bi+8zcTn8EHkiDve+E2na5Z8RV1kKDKWOJJZAlyO4kAE3eFL66H1zP94PLI
         fo/I/u3bXJ7t9/4gmgAYIwlMy2QOni7nUXMTBdzwD8OCKY6QxgzUSJ278+x0o+l/gjHY
         TsG0mrFAy2M05O66Vsc3zsRUSTXEMAlcEVi+4y/U/U6+JyJ2zlCVcajWS9mIRl5tKZmg
         B/kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OYvXUAY2hmuPvlFnXce6eIWWoBwZyZWq4HDuaCVxamI=;
        fh=Ic1+bM3dE47N+CA5TwXHsWr5uX+hah0o0WNPW+gb7wI=;
        b=EWjoC+IWaCiQI0HMrXI3P4ckfhlahS8LI1Uf6AswmQTUzyWM5heHSDwqGdXJC+ZC02
         ai53/rFEHyfmwY/dZbmOH3yaZuGr5u+QntQnmr4zWBVNWZ6qAVC0D75EEMwR7rKnbsTX
         yCx4Eg+VFh+KPOtLMdo0wGP960ctrd8Ra/z6zcoj174KK8SnpqoQiDGQ3KZCBQmbLGXQ
         Vq8spMvVoRNhZGvJsNojHchiqhNcg+fnWokYBUI4L33hezdPkpuaEaGvP1svlyIx9aGo
         31WPN99dJ/u7UzIMASS9vnw61z/2UyMKxBBGTTbHtMjmuRErbM32OmvfZhL163kJEhiy
         D2dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1772918758; x=1773523558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYvXUAY2hmuPvlFnXce6eIWWoBwZyZWq4HDuaCVxamI=;
        b=PSifYJS65SNjU+/ysAcvD5mfLC8j5T1AGtjLC01TMMYO/qTeLyiQbQZwxPoXRuJeWM
         HwnYPZYUZPoAfYiami+ROvwrQEWgPkkcS88wX+7W/rH0bjAepN9ZpfobNTqsxL52gxRl
         2m5pDsyeM2k8dKvwiVmW21AL6PvILplFp5nMIOB/ZvGtST79eKtyaen6WwgxqF1CjcmL
         oEOUfIZQ4k918G9v2UBaLcElyfC0OlFQ3QnzQE8Ng/vhN+PoaywyK1qzRyb4xpU2dkt9
         MSP9sY4SSg142/p24D1G7fycA8kDSoYEVqbrZbtIGWafOGwkbuw9HzZ32oHsi/2vpqka
         gRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772918758; x=1773523558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OYvXUAY2hmuPvlFnXce6eIWWoBwZyZWq4HDuaCVxamI=;
        b=o8EK8QkF3PWeHvFeMvpGEdDYYy5uKvzE3pR3piupLi/fdCddWadz1duKdqOy3D5AW3
         x6YLjYNoXXypyZkcNONM58hbpmkqWuqJM6Q/CdOQ0XPpfy5eAbh5msQzxA9fjesIVs/K
         k3iIrCr+kn6NJf4UC9H5P527PzlWUG4REKV25swLTxAjPn7i4vX03S93cUC1BVw5PAjl
         peE4x2nwYESUfIfEFPz8wsDm2Fs9XLVg319r9wbnecm3VsytrEXgXidAHdw39fDvVBqX
         w7VKmo1Nek4JUWD8+nh7cAHHY3FYjqwqBJjn6RvvIrghk6oKjDRPwodbrzP1FyPmBd5C
         dppw==
X-Forwarded-Encrypted: i=1; AJvYcCW3JfEGxswWntTTOhtS700K2G/HGi/ZBs4ZOozHAjuUUcO6VP7svQ8KZ43dHN1zCPYQeVwP0Yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLSyxC8APh/6A9HxWPDuYi5KZoAm92iNktviVr7/+xmWGggoC4
	fcd3O9HEKHnaHoXGetA/YeChaqnDEqXpCfiYTBvTAt+f8ME+X18nI4p3muJ+g82fP/y6IXMOwtQ
	4Z9zxGaVDmx+qTzjS7n6jN4vDH5WfQkWzQJeGu7wC
X-Gm-Gg: ATEYQzySelsH3zRKaoC7INmHZdECQ8wWZ2E8kno3KdHmZhv4ug5OHrDEdbFBiLn4IvC
	vLct2Rl+ojiFnjxiZcy9alnV5P35rtqDYOmhZlxl8xq2hdBIOZGz+jXsDrVD+sblpRKQOMGSxDd
	57NuKywH0nD7NqqW5s1+JEu9idTAiDePj6x1OkI4WyF1ACxnNJK8/9avnouBGll9cb74TtvHHTT
	jtLzdyJuWn+KNdQf1Tbn54FX8FC7GpKVfV52bsgTS0z07hE8nXxEL2RZSw5hKYFiOpvZgzZwvv3
	/t1DW+wiCIK7Tlg=
X-Received: by 2002:a05:6a00:928a:b0:829:883c:1d5e with SMTP id
 d2e1a72fcca58-829a2f6c373mr5530869b3a.30.1772918758566; Sat, 07 Mar 2026
 13:25:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307120607.3504191-1-edumazet@google.com>
In-Reply-To: <20260307120607.3504191-1-edumazet@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 7 Mar 2026 16:25:47 -0500
X-Gm-Features: AaiRm53Opprvr41x8kL155vquQrQ-j1OfPPykbhjnDSECmyWMH4mMpr_JqO21CI
Message-ID: <CAM0EoMnQepA=vSb+ti9QOGYL_Mwc1M3Li_6MHpUNtjHJrqQewA@mail.gmail.com>
Subject: Re: [PATCH net-next] MAINTAINERS: include/net/tc_wrapper.h belongs to
 TC subsystem
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1B68522DB13
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265185-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,resnulli.us,vger.kernel.org,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu-com.20230601.gappssmtp.com:dkim,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Sat, Mar 7, 2026 at 7:06=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> include/net/tc_wrapper.h changes should be reviewed by TC maintainers.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7b277d5bf3d1247544a2871b794b578c5675cdfb..6175c34910269fe6d1d20cbfb=
0985e25ab72fc5f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -25751,6 +25751,7 @@ F:      include/net/pkt_cls.h
>  F:     include/net/pkt_sched.h
>  F:     include/net/sch_priv.h
>  F:     include/net/tc_act/
> +F:     include/net/tc_wrapper.h
>  F:     include/uapi/linux/pkt_cls.h
>  F:     include/uapi/linux/pkt_sched.h
>  F:     include/uapi/linux/tc_act/

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> --
> 2.53.0.473.g4a7958ca14-goog
>

