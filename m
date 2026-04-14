Return-Path: <netdev+bounces-278468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCevCvpL3mkzqAkAu9opvQ
	(envelope-from <netdev+bounces-278468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:15:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E173FAF77
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38A92302170B
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 14:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895163E7179;
	Tue, 14 Apr 2026 14:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUipLdF+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C74A3E5EE5
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 14:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776175799; cv=pass; b=YqKHgmNuEGiPUrhedIoOJvm18BJSHmwEr8+EZdsKeOokcRB5hWt9Gv5win8nTBqlt3Bj6VGJw+aQapSwXGy1WZ54YKJCaAhGLphev08Lz4mneBTkLAN2oq/iOyQMZ4NsQIrZS408oxSe3wckQdIpQw2633uH1aEQW1w2F/FUiT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776175799; c=relaxed/simple;
	bh=nvHkXaKy+A4a3zjmlxYTM7ZEfGs/MAzu/4aP88j9k0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L//M6J6OlBaqkdC4ndZ2sO9ypYhCKFeOOIHdN93g6hlTltC1jlpK/stjbS0o70S6BYMD8mIri5ty2VJfjo5dkh+xXwB/94yzone3EGYwgH48IzYvk7aQU8/b4mKoIt74PrxcILLDjYmGjk+w5TFA7p4edrjPmzzgS85yKdTaC6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUipLdF+; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488971db0fdso55974195e9.0
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 07:09:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776175796; cv=none;
        d=google.com; s=arc-20240605;
        b=RchJZPjdMIIyAjFuArnTloXFoZsTMlAmmJqvbyGYlQ5IsK0F50wHYxESowm8rXPi6k
         dB/X2J61o7xs3maQjRBI2j6sL6j8OqzAVlfTD1+lWg3aRYhBAh+TYbdYHUeiO69qgbir
         98Bv8VWN8lsX9h2ZSJBU+zs5ZEcNh/DmqaZWg5gCON0PGtsBJPgJdSxBo4J+0MIt25jY
         ee/+a06v0bHar4RKMMnwMVhOuY+/oxB2fz5wBislEpfz06QExCQcwqRcFR0GoCaqQiEs
         YoS+HJA+WqbINZEo1Bt93wWF7Id6pOWSpDa3344OMUT991p3p2pH6+Zd4fFMIhs0gct4
         MuDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n8OdkUuaCi8mFEcW4isBiQRI/EoubzWNeked/wrjNEo=;
        fh=ueLkhL3fs2XB6NE6u0SEknG/EGAH6QQ1j+k2tAmzy1c=;
        b=ghr6NPsGzwKxJC6AF5He+4te7ggQW111YNqSBSVk1jFoK8toI0oQNzPVNBpRSj5qLZ
         nMQF51TKq8HdzDJH76M/DDS7k8O6S/K2hIKXivtBeQsmacmjwr6m6zQ1a2d0JE1ybPRW
         adodueAp98VzhMB5esrhzPmFGvvOwEwAJXTxO3ArgEWhwIDBlhLamJ2eiLW2i/c1BAfg
         lpWs4xxKL1x3nEA68ALwO7As/IzmVV2qPLSd8tBdl8IxXloJaQCDU737ghv6EMfBg/Pk
         VP5wEqke8cDBLOJWFxNlSC1gv2MQrdaYVvuIdWAOyJRpr56dd46FpJt31GmQtdNV9c/h
         iksg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776175796; x=1776780596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8OdkUuaCi8mFEcW4isBiQRI/EoubzWNeked/wrjNEo=;
        b=eUipLdF+z7g89ab356OR86U5Ekyr0FCnM4g1xKC3P8S99Biooamez/BjQ48bWBVhV9
         xxEgyg8MZ1LU1uCZ+1dDR54VmNnmAQULNoVioLzx0Bf49J71sSujW1z+/B2W+Vi3ZB5z
         8CzfjrBbrE2qPCzVp7mLvbcPe1BU6rQQDRKoVmisTfzYtXE+6HxQhDyxbdDrP/syx/qP
         5QNXBqbtJE2xdUvOLxj+Qdgd2InmjMj41Cz9BAENmeFu9dmH+nvwlGzoNq2g5diqJD0U
         vi8/osUiwepEuKvn8uUC5gqBQk2RnzCfR7L7gN1W+iMCNf2xHvIdR7Uo6QEz3II25OX4
         HjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776175796; x=1776780596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n8OdkUuaCi8mFEcW4isBiQRI/EoubzWNeked/wrjNEo=;
        b=JsjSM2d1Fu5aY9KCAuNKnWDDYcVXTkpDkpL9mzpjBrVVjmeI+xckm602Hgzxc+v9yT
         VYtds87zsI8j+cTBKalsH0F6xa9B5ZdASbjuGdpBwbDfufzONV5FvAXQgqBpVPKq2gzG
         Ihn+UMgMYjI8NhKCUnPefEF+oh8oWWISgizlFViW1Yrwr5ebBOaJY8qRLOjwt2O3+Gs0
         Cgt1uxc6KoVwzE25zPM8vGmwiF/kPJgeDC1iWlRKTr+tAdUlUvQPrfSG90ZXENMQNfww
         ihXrXUY+zbAywJ+2DO7vij7vEewA5QgeoJa7IHewDNPV2ip75pAAut6bnBRaLOi3jLzb
         ixfQ==
X-Forwarded-Encrypted: i=1; AFNElJ8uPsLJ4WdJeFIsLISxOfbhVWSUCYHs5c10mwqEqajMZWgcHpaWVmqb+EDeqniRWpHV0iPhIw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXaHjX8oKDSEPdy6R0znEOTGgXwD204wQFas4WOitvbTEVeDkN
	KTVYv5+UHWqXnrFGYJtUl+diT50J15dXa7DzYtGmQQEh43qjecwh+/mLqXLN8Z3Z/plm+Ug59IJ
	a6sC9AQZjKmHnccEs2YDhpKVE0sT3dak=
X-Gm-Gg: AeBDietQqB5GgABHMzUV18T0BmrrUi8MSherqts6zLvEEBkAUgJl1TftlmqvOhtu7BM
	1r5K9C9TmQag2p0Icw+DDtp3vgCQXpwU9VMnIIgkmEXZWhq5NFcqzyiqWAgIt1MM5d271S6MLBb
	88UhmAqezIk9wM84zCjn4P18Q+/gxY7Y5fouLP9fn1U5hdc6eQMNgIoMKznKuhF4rIPc+OV8CPz
	ymeSAVfLKcgs8rvQGzf6xOWLe1zj7N6cN7VHRbd90mNQcia3gcpBnvg2B5YS+IvUxUodQlS7xc4
	eAlUUz0wVOi/wzStqALJnwY8Md0waFZ9kHEd2OkDIUODQwl2y5cfst+x7GqMmR53GUf2nmQjPhV
	Vq4gFgqXzBkp7AL5AG21aDqFAyA==
X-Received: by 2002:a05:600d:8449:b0:486:fdba:f5db with SMTP id
 5b1f17b1804b1-488d664f29emr197490795e9.0.1776175796268; Tue, 14 Apr 2026
 07:09:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ad4whCJuB-viVAae@sirena.org.uk>
In-Reply-To: <ad4whCJuB-viVAae@sirena.org.uk>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Apr 2026 07:09:44 -0700
X-Gm-Features: AQROBzAq8LwGSoUQB6Tp7PVEnWgUkhAM1WnjY5UlIcDEYXRlptGcA56OQDX1H8w
Message-ID: <CAADnVQLz6-LK4+qad_XqEZXrspttpe4b49jRZ6wUCgEhJeTvgw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the origin tree
To: Mark Brown <broonie@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278468-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[iogearbox.net,kernel.org,vger.kernel.org,nvidia.com,gmail.com];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 82E173FAF77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 5:18=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> Hi all,
>
> Today's linux-next merge of the bpf-next tree got a conflict in:
>
>   include/linux/rcupdate.h
>
> between commit:
>
>   ad6ef775cbeff ("rcu-tasks: Document that RCU Tasks Trace grace periods =
now imply RCU grace periods")
>
> from the origin tree and commit:
>
>   57b23c0f612dc ("bpf: Retire rcu_trace_implies_rcu_gp()")
>
> from the bpf-next tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> diff --combined include/linux/rcupdate.h
> index 18a85c30fd4f3,bfa765132de85..0000000000000
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@@ -205,15 -205,6 +205,6 @@@ static inline void exit_tasks_rcu_start
>   static inline void exit_tasks_rcu_finish(void) { }
>   #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
>
> - /**
> -  * rcu_trace_implies_rcu_gp - does an RCU Tasks Trace grace period impl=
y an RCU grace period?
> -  *
> -  * Now that RCU Tasks Trace is implemented in terms of SRCU-fast, a
> -  * call to synchronize_rcu_tasks_trace() is guaranteed to imply at leas=
t
> -  * one call to synchronize_rcu().
> -  */
> - static inline bool rcu_trace_implies_rcu_gp(void) { return true; }
> -

Right. I mentioned it in my bpf-next PR.

But how come you're saying it was discovered "today" ?

Paul's commit ad6ef775cbeff was committed to rcu tree on Mar 30,
while Kumar's 57b23c0f612dc was committed to bpf-next on Apr 7.

"today" is April 14.

My only explanation is that rcu tree was not in linux-next until today?!

