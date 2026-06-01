Return-Path: <netdev+bounces-293892-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBo4GAPUHWq6fAkAu9opvQ
	(envelope-from <netdev+bounces-293892-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 20:48:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D6962624404
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 20:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC495304B886
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 18:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6274434C990;
	Mon,  1 Jun 2026 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MHfJGsDH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99A135202D
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 18:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780339617; cv=pass; b=rH2fnxqXuI7JTOzUmuYrrrxgYCp7YYx+x9xDDsXLCHgRpWjyK5HXspWic3aU/cLV6RwXzj3T/c0FJ3Xn8U+LLTXMGLAuBd02yzJ0IwLY1ocIDVE2HWYJvYB8gg6mwyUCXxNtcFNwKQPChWUam+wQS9E3/LK0bv9ufdsP250xSNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780339617; c=relaxed/simple;
	bh=oXz9Tg4gu33xF/wC9+230+9RrBA3CUmm/0k/7xBqZJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ny+P92fZquAGNwTLD0C6hKKmpcaSykfnHYij8MHF6NNSGiXOocKRUOEhUTRFoShgYxJjGWPipcpp5h8s8Ns9YpDS03Jf3bX2vjFRGmnIoNv5wDqO3YmzCZTFy2nFhZtmH40yZEdbV67tkSngzGRVyg0sN7z8dAkurafSUkai59g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MHfJGsDH; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5176096116fso6638891cf.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 11:46:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780339614; cv=none;
        d=google.com; s=arc-20240605;
        b=De7JGQrsu9KNdt/1Aa5shlx9+xGq/GHsgSVOlqeui2aSQJBosWx9Y4Y3J3xkc9kE0x
         4UxBpJLgCK0K+ndz6cpTgrGiYizPraszZ6A5h+kxFfLA/BymTsCIwp9TGuz3HyuiaGPb
         53ETw87ksv+sxdm+gLKt0cblYZ/5dl/c8B3m2eyPDMMSAlktQrVgx/7+8SWaiQBToS7A
         2/cZ7Yd4KEn9FFjDM3mrnh0qqPoy3KODWuoqrUaOa0Po3iljts+yFFaCjCsk7gDy+YAK
         btdeMKP5QJxFuvSekLbXsGosywWuvAkgV5+vhc2TEN5gCltrm6OmyiTcSgYAbNR6khr0
         dwnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oXz9Tg4gu33xF/wC9+230+9RrBA3CUmm/0k/7xBqZJs=;
        fh=v+Vp9ejRwOCZ7oZChAQ8eCkd/zksp4ZfwXxay9MIFbs=;
        b=ZEpfc3fW3dix5K6hdl/kutnX1y72F+SDnsgp8GJtA2sheLuMlafox3s1HQpFVq1420
         teNIUqkkrTjv+4dFQkkKHMKP5RZXZifAUNMvqqgai2t/w3U3XW8lbG3i9xVmBgK2nAtV
         xrCBMe7+q+uvtIxRkO3/uZ9kjbCE1pgrmxA7mRljxhrZ1SAjlZ2/h1h8surqjG4EZq2Y
         BgLsoFLbPkTduGWjoPTVJnHBK2BtVyMMeH204beEJoRULdm/DTFVc0rxJsqQsKpPoro7
         +teQJ/uj9ObwRh6nnI9O7SqoBFAzzkjPMyJgblOf4p4zjSCHyPY4B4yq5cnO/AA6NNeh
         igNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780339614; x=1780944414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXz9Tg4gu33xF/wC9+230+9RrBA3CUmm/0k/7xBqZJs=;
        b=MHfJGsDHtxbrC8PK2IWbKxsbAoBoQwVy8OYxyzSx+zVOUYFbmO49A9tGr3GoQko64t
         O+mbx6bi3F712zr9r47lu8/PLdxZfwg6c1jxnkx56kPCaDDpg8waUC/k1HM8vSGqRGvy
         BEEgW83PwjVqQrQ1pKbJ4wHCAW/7hRyLKzHBk08faZuOcUjA6EPgL/99WQqV2ek1OiYi
         +6EXEK8c6MtUDW88ltFQk+c4aGGKu6iTXUYShJk7uNe7kYudMX5p3h+1DnLTj+XDCSnE
         v9IpyE8+YGUjaYsXHsJPTCaTHxUWDNQtNk3IrebQ53QQ+c6awDhOlvQkjVs3ojzC8tKn
         g7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780339614; x=1780944414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oXz9Tg4gu33xF/wC9+230+9RrBA3CUmm/0k/7xBqZJs=;
        b=VpN0HJ8Eu708pU858DvLLtKTBJ423OTv35q97jmLFvDZrPAGsMTtToINwIQKaf8/ZQ
         1v4DXTk3RULtjbn99uVHv4mDoqx4zTTL36h/jp5svOc+m2OLLt2Q2/TkkokQH+Q5IaM3
         MwXovWQndg1ay6/6nkk4JP+00+O/o3lLq69Mr72LKAdDcdY+xoF+aZuIMS5Lki+4T8G2
         5DzBchSozDLJHfPXoiA34JRlwYRrLt7YSqTe2N4tXjoBhgF6yc4KVcSWrMiJVn0FG09Q
         80iBkrKPLp8gLPeJkem46qGxhCwt3jZQ/KFvu+ajUlXUmf1DjbYYvHpqs64NBXJgLPzn
         b1lg==
X-Forwarded-Encrypted: i=1; AFNElJ+Lt85007JBbJBkb05ovOJZYsKeuEQro/3Fd6h7+TpOBx6Wgbywsxw6lSxSEu+xt2dazxo3LH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ypqdKDA2Y57KJnxHIjtdWRVwm0KePcDYiE8ErSjYGvNhPwQp
	HnhGGCH/rjWqrMd2kwfmPHAPqZcClCoqt9K4+2wsymQlqJWp7p8EmAu/EY7I7BecileQO+6vae2
	IFfo835eOd09jo3HhbxiZLstvhqpj3V772NwQIcAk
X-Gm-Gg: Acq92OGiAl7OTBhpbqvx5wou2JBPoqhSXzdstwRchjiLfpkHuio3HbDBv56XilEd+i3
	r3f2YN8LQYJw7TtFRATAcKSKRs2BLY/g+CTlBu305Jqy3R90MlysaP7jyK8c06EIZjGdNHxlpsA
	Lk268pW+2cAxu1byYI+SoBCjjy+3uInooG8iqeH0S7vm2gs8cHh1QFcDVGoUh9MdQP8zx07bPwI
	czRs8jqcyZR4kwhX5pjzs0csDwBFnih/0n13//rzs06UFJUE6BHbtUUW88GcnId9g3mvxxUcrIJ
	6ZLAU4csQS/L4ZP9+nM+hQ61awGX3jBl/O6b60BCWGSUYoitUxHD5ZYnAtG/8jcZsG1F/ufmvIO
	373HL/swdFIOVuWnxUkJ/3NTVpA8hRxRmH8scM8Y=
X-Received: by 2002:a05:622a:1802:b0:50d:900e:c1c1 with SMTP id
 d75a77b69052e-5173a6cdc08mr180423101cf.7.1780339613305; Mon, 01 Jun 2026
 11:46:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601182101.3183993-1-kuniyu@google.com>
In-Reply-To: <20260601182101.3183993-1-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 1 Jun 2026 11:46:40 -0700
X-Gm-Features: AVHnY4Jkvnq6jOGZ4k-wiN8Wo5fLgJvrdCP8vRujn-7H73ngUutJxZ1ENEumVLo
Message-ID: <CANn89i+Qg8Ht=N=OEs3wkmT1+65d+2=VN-wLm5i5NtugL+OhKA@mail.gmail.com>
Subject: Re: [PATCH v2 net] tcp: Add preempt_{disable,enable}_nested() in reqsk_queue_hash_req().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+e809069bc15f26300526@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293892-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,linutronix.de,goodmis.org,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,e809069bc15f26300526];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D6962624404
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 1, 2026 at 11:21=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> syzbot reported a weird reqsk->rsk_refcnt underflow in
> __inet_csk_reqsk_queue_drop().
>
> The captured reqsk_put() in __inet_csk_reqsk_queue_drop()
> is called only when it successfully removes reqsk from ehash.
>
> Moreover, reqsk_timer_handler() calls another reqsk_put()
> after that.
>
> This indicates that the reqsk was missing both refcnts for
> ehash and the timer itself.
>
> Since all the syzbot reports had PREEMPT_RT enabled, the only
> possible scenario is that reqsk_queue_hash_req() is preempted
> after mod_timer() and before refcount_set(), and then the timer
> triggered after 1s aborts the reqsk due to its listener's close().
>
> Let's wrap mod_timer() and refcount_set() with
> preempt_disable_nested() and preempt_enable_nested().
>
> Note that inet_ehash_insert() holds the normal spin_lock()
> (mutex in PREEMPT_RT), so it must be called outside of
> preempt_disable_nested(), but this is fine.
>
> The lookup path just ignores 0 sk_refcnt entries in ehash
> and tries to create another reqsk, but this will fail at
> inet_ehash_insert().
>
> Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")
> Reported-by: syzbot+e809069bc15f26300526@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6a1a7bcf.0a9e871e.332604.000b.GAE@goo=
gle.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

