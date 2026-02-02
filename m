Return-Path: <netdev+bounces-255782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id doyJGmxlgGlA7wIAu9opvQ
	(envelope-from <netdev+bounces-255782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 09:50:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD009C9CE3
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 09:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90D99301D055
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 08:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3825428031D;
	Mon,  2 Feb 2026 08:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nnmsuCZJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C641DF987
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 08:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770022059; cv=pass; b=d9aKlF2dNflVS39qR8VVLbyBAPyt0frUYh33BkGb9YxZGFq5bc1OsDdqSJtfQVhlmfH7GrOvoEPnFFw7nGw5CXbRgwACgcQmrhsATwGF5dq0USscH92mKYOApRboETWJ9coMUuTFTyodN4t8VYf7r49GaClBbIVT2L6ARWp/tKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770022059; c=relaxed/simple;
	bh=f3EBzQ1DR9ZztD+yc2ZFRCl0v05AEKWfZjRkL+FGqng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6DGdsPmPfUUcvZjzSUH0k2e7+k16nqn5FuJf24WwbXM7U+WfQvdWloFF8si1a0dkHfJII4H6kn8MwDdf8jDDMJJhHHCfyxx4o4Lzut1xu0enkaw+JhlM9qH+El1go5WYsmSMH8koLWHuA9bNs3/RrcddMCh1yyN0zp1E182mLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nnmsuCZJ; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5029901389dso33311051cf.2
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 00:47:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770022056; cv=none;
        d=google.com; s=arc-20240605;
        b=YS1MDGudAkfnulMd2S6bavk0St9qHFRgJmG0MLxK0TlDU0u8rHs0pwXwww9eX5imSy
         8z/7Yi1RbS4xmgl+KLvayvjZR55LmRa7oAHBhF0jtjqsDXhUS2O+NtL69W0V+sPuw4h5
         BFAMyFP73Hdn+Y44ootL8Pf2ChB23xR4amI4pzohihdg0Zu9yhDoQ+pCUHQPUYizJHlo
         DYyzq/it0ZlLFJq4zBF7zjwJWmdgqppv2/XsEpUYJlAlZg5LlAIJrnhPd2HFqSDnawI2
         IWu39Y/KJTNK7JJ0foKYY83PcK3/VxD9erh65sD+ojLhkFhbVWEytnKFZJhXcbZs20Sa
         DCTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2Wh158BDeQKIEKJM83wsN0YWinwVY007qOkdgvTYjsw=;
        fh=1YIesu/keCjUywDRFFMK4q4soZu9zqUWc1y8BbVXIQ8=;
        b=FJiY7bn2NaP+48ClGmtxU0PaJnYxeyXhI0R61P1ea62T12usLH6Z2Pd9nYB3hte4S+
         JPIRqf2HkpB9gNc/bKTX0Zxck2kqyUAGmUHXFDNBYFSlFTRrVtmpRHE+4iUj5xHWPo7Y
         4BaIUnRJwchugC7srGdDT9uXoshBoyvFRbmAozUqsqRAv2mxsfvfH1fSqgk1r7TcA5AT
         UxrxMJf5LlzbKEynlrxjKpWZ5R0B6wu9skvJHWWcy8aOBJLoULGp6SjE4TXXuKpBNAa4
         6e29SKN86AtW/IFC59jQa/+mMVv6EdSM1sSmanXTIWuumWJq/uVse2iqqFnrPq0MKf/d
         haqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770022056; x=1770626856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Wh158BDeQKIEKJM83wsN0YWinwVY007qOkdgvTYjsw=;
        b=nnmsuCZJztErw6He1ntfb+/KJglWEZSPUfN/uBYyZ5/Jr0erxZguXzOmldsd9EkPne
         zY+gKxMxd0WW20PmGQrwqrY6BSKHXafDeyr+eGlhyQpXxJD/ID0McgZLKy9/drfF0sBA
         LFZ8zr2rRDUybn39wSMsiwtbLKi9abMubLa9JQrOTlaj2PHThSPJZOgOGce4rkcHzmT8
         zso1zH8CkHXcLSVNPqexZOYM0AyElduR1+hvgjRrKJDIADa5RvrFYQM7z/ik9i0X0Ydq
         IcfgE4CcNT3do7BaL9+XXBrKXVIuN9BlzIb56kut7QDJ+ZennlSh6mwAi/v9j8nEc7An
         nLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770022056; x=1770626856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Wh158BDeQKIEKJM83wsN0YWinwVY007qOkdgvTYjsw=;
        b=EswFtaKQDTU5hcj5WOoZq6pRcAfh8F7WpLHvi3mu2zQ5tCPjwdY/o79XMFqFPRMVx1
         uEIH3y1R+IT3/WNczR0MVPEMz/GZ5Hpttsal4B6es1rQtk2ud2UW7dAbjh4zJozY6m8u
         hgWw5FWVpriSrY2XyUe7Rt9+Sd4MfNQtUZNb7ALzmXkbiWLC+Ei5aPKrlAlr9kXwuXwh
         EKtGCJyVISus+yIN0WY+ce3nxA5UuhYiSwGwbcnnomeRgGu5jNLTLMDg5E+saP5FuWMB
         PCIeuY0CUdi8yIXeeEuPOndnuAlFItjlgGBS1xhSMIuqaWTQ42P+1fkFSBGRAA9ncwdj
         TyVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXakdxZGAT57svin7ztEXv9Aja4Kl2S4H5ZDqsDNlOgKW36zipe69fmkMWFzmflYI6vNQPb644=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKM/YY1yippa9HQW9tQcsYYezYbylC27qP5Qd9vitaeaRtQVai
	fOwWu1Q0w5yJz/doJfEd1Z12p0DH749hd68dZyY6qeQutqRonFhqp9/m5A+JpTfteVk5XS8hq2h
	zzy8Q0Zy+OuUaVmAkcliyndDzut3deUGYIQZT1pqr
X-Gm-Gg: AZuq6aLZVAGnNQjaGtmnkiQAthUk2OOwxua6by3QMWRnkfOx6FNFEjmjZdP0vlyL2Oi
	3grx4xuvSVzDVUBREKT0/0FjA9hMVJyz3nnJVZb0cjnRtFwApMp2Jl+e0C+PFZ7vsOJc1QT+ROI
	egBb4an1EdaeJgh9XoWMt/9szmfIHUu+MLKa4/M2oykOwXhWvUUTfUYcL8hzFCagDwF4Jz/0ghN
	5WlJOAqSHRvt7Nf9KMaC7wQIA5FK9SQj/2OBXwpkVKSZSVnFzsUcEwU6o/xxtrMNBIpPx8=
X-Received: by 2002:a05:622a:164b:b0:501:498e:5c29 with SMTP id
 d75a77b69052e-505d22a6026mr140164241cf.59.1770022056291; Mon, 02 Feb 2026
 00:47:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131212934.2547995-1-edumazet@google.com> <j3fofrzb4c3xcckk55y7rdpc7x5m23mphkksnp7vuijimzqpml@3nzu5xyfuyer>
 <CANn89iJh67=bSTS_ziVuQUS-ht0yqeW_Q8eaFCV=8M7zuETAsw@mail.gmail.com> <c63047b5-3059-4176-8d9d-5465d557e605@huawei.com>
In-Reply-To: <c63047b5-3059-4176-8d9d-5465d557e605@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 2 Feb 2026 09:47:24 +0100
X-Gm-Features: AZwV_Qihiqmyuz2svNCzoKpZgPPdX5H4t-ycwMXpy02kDXVhkRM4_j5kuyUYDc4
Message-ID: <CANn89iK95qb_=KWrcsvqEB9Bn0PXi3JkY5h09NiWuVWARABOww@mail.gmail.com>
Subject: Re: [PATCH net] net: add RCU protection to (struct packet_type)->dev
To: "dongchenchen (A)" <dongchenchen2@huawei.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	fengwei_yin@linux.alibaba.com, zhangchangzhong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com,linux.alibaba.com,huawei.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-255782-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BD009C9CE3
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 9:21=E2=80=AFAM dongchenchen (A)
<dongchenchen2@huawei.com> wrote:
>
>
> }
>
> [2] add delay to pype_seq_next
> diff --git a/net/core/net-procfs.c b/net/core/net-procfs.c
> index 160dd729178f..73f5a20ef57c 100644
> --- a/net/core/net-procfs.c
> +++ b/net/core/net-procfs.c
> @@ -230,11 +230,14 @@ static void *ptype_seq_next(struct seq_file *seq, v=
oid *v, loff_t *pos)
>
>          pt =3D v;
>          nxt =3D pt->list.next;
> +       if (pt->dev)
> +               mdelay(5000);

Waiting 5 seconds while holding RCU is going to fire the soft lockup
detection after ~two calls to ptype_seq_next()

What is the actual trace you got, and what happens if you reduce to
mdelay(1000) ?

>          dev =3D rcu_dereference(pt->dev);
>
> [3] run_test.sh
> ./packet_type_test &
> cat /proc/$(pgrep -x "packet_type_test")/net/ptype &
>

