Return-Path: <netdev+bounces-259639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBwJN7jKl2lV8gIAu9opvQ
	(envelope-from <netdev+bounces-259639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 03:45:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0D01644AC
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 03:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B62033012E9F
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 02:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B84126056A;
	Fri, 20 Feb 2026 02:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YE+wQMTZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7AE15ADB4
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 02:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771555510; cv=pass; b=lCMrqRQOnY5OhT28z/7AVOtamCfNUc9glZSDlXtT3qvBYNfj7N334GB35wdXtDH5T1SB6rYCfCKncIRKDLXjbBkFxBcx4mYkUyPdUA70Vm//u7NTwPGckwXJKeN/hQD+CjeyoDe9V5db+qGwZSINEZcby+3gOvSoEMt4uMhKY18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771555510; c=relaxed/simple;
	bh=SBxQIuxdianCCp23hxjDBvPBJ4E8gh2doTeLXvNUrJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHsn4xXqQR02dSzAmqMLAFCV4BhhugbnGECwpKSyoCfM+TLyfvPqSnNhX0K3NY2D0lDAEXUV05uBnbucwMNmhQ+hUqi0LWCXeQeBiuSpQe1OH6Lw2rVhYMQLJnpiNkpUrMI0ruEfmfLTb8X6W8FgkhlHkMfSbl/MPu4yK62OitM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YE+wQMTZ; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4376c0bffc1so1216054f8f.0
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 18:45:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771555507; cv=none;
        d=google.com; s=arc-20240605;
        b=Ln3CAbrbsB29yIbygGd51qtCZaQ3v5GMLFhNZmrZk7n02HksSL84vXxFLiduoTW3dg
         OwwfWZvld64nuIi9rmA4jS5wTDpndrSzWYQWb8lsn47w4YNeKn5VtxYTJLY7OFB55WCE
         /v+y1Mfsic0T4olFDI/4p4nFFvhsWsE36hM/q0PBEyfIET15VT+3WSr15EHVS0TITv8n
         s/eVN2mm4razkf9D5jd6/jqpvOr1Nr0VyOTlwAzJidnPEoDVIDqnFDR5lPGNqGgU1i55
         n+8dMeq6BJZZymBl6YwavvNbpvGl35UoFVh9jFDMwY1aXiQCxLUlRD7geX6ceJjz9VKt
         0DfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U4XnDZ3zmMGkSK9IywzENGPPeHxiXcxzEzhSIqVZkZE=;
        fh=iwl98y9We34AtCnTbwf7oJmfUMJff6v74BpFdpdNSKM=;
        b=cCZ68dPIy2UZiHoXIAKvLty53s1JIh9EXh+SEnY90KU9Q2ZJ1CCF3s1gKiq9Izg5Ny
         kl5bpMBF2AM33fg8ykZEgqg5L7qIHbyQ22gKnKFzZWNYwY6yWzrKutinTcyH6LId+/uA
         759MBIkh0NKkwrHLLekBP1GwY0QuTyL+SvHJyv9cY57DtvlbSDESOFSZVULJLCowQ6a9
         OfbnfAaLmqCPZ1ZUYD77UhlrHeiCLfSyrCVHO4eZ9+Lgn6dJdgEhr474hBGKq9eAeshR
         +ugpW8WYsSI4fhfzC7tBuAGAdYdqystxXrcDGkygWrvKfSBmCVWCK2G6ogHKwaKXBPn/
         UALg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771555507; x=1772160307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4XnDZ3zmMGkSK9IywzENGPPeHxiXcxzEzhSIqVZkZE=;
        b=YE+wQMTZRp2BSx/fKi5b57/OtiuqIdnrBuwGfxKP1g18CPE6Yoxe36n4W2YppGcZV0
         Yz27v+VAVWir6ZHpgiNlfO/972HofUx/3uZLFZQC3apJc64bkijDpdFfifejyGqZEdw5
         fPWyqNl0iidcc5FZwP93mHLFhYutxUA5hwqUHEzxrl+GqJFE44nOIw08OeYZjzo15p+C
         om+MgJ62vP9gRAhwbTTOzAqZO4yQfSuoy656VvkGN3sJ8/LMeYUhWUoZXSQ3fNQoNvLe
         BF5wnjGwyhnQeHtNumOyAMViRbyrtbQQs54GXz9Wim6QD86FskZqBdOJmXHtnjtIUPdi
         bt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771555507; x=1772160307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U4XnDZ3zmMGkSK9IywzENGPPeHxiXcxzEzhSIqVZkZE=;
        b=CXwxoF+3sT4ybJDeyNGnOHhW1LHwD+o/M4IX90ylN77IIPcBNzPc7Wxrut4OtGVeLE
         Mr8Klqdk8UVdyEfrpwDLXIhnG1YM4dm2tBtRoz3mXrCNuaZ8i2YvxDTVAbfebOcB8x06
         MoEB/84ZUjqytKdJzzll45sT47AXY0sidp8Lg++rKGnBKOv4/V+tX3zK4kgVEPp3oulJ
         F8+DmsdbMu2GvqdXq8j+eHtyWhvkXYo4FQ3wb350+wIleSCmh2BnVHED3QGOP4AyhgDk
         Cuz9z9/Ucfer7LAI0UmRgygppkKuKjygU4jpn+K7O7Jpq5QJZQBTv7KcTcI6bUOT0A5g
         9eFQ==
X-Gm-Message-State: AOJu0YzPMfsu2/UQUaqrbQGoUtfO3VmqlN2+YqgW4XFn+yzTw4fNbj5c
	2Gai3jJdHUqYiiXimXnZiaokKwfR4LkhCeLufXr6bSPZQnQI6tR0DFxeV+Lgq3/1sjigKh3bkB6
	qDimfrmFt5G2hvJzmosy2P/obHSnyg4A=
X-Gm-Gg: AZuq6aJTe+PKMY3RzR5qiad1A0y+hshu2aRAKivj23rd9qoPkdcBpc59j7bidF6Drm9
	C/Qmv5jKtP6wifDVFJ/uwyWzHgH20DUDU4lWRjo4YP37YjEtZCrhFyRRuhRTd0OQjizysztKiZJ
	RXMPLnLFMVM8Vfn6XicYRySZPYzAWNrL1y7UO37U+OWZ/+ry+yXpg5E71589pV0YTE+KKwOADa/
	GbnKfEVE1wBY1XrLSeLhpF4W8FQkCjJrIlFSv4K9IlJvMMl+ghWrx4l5LZ6efrUW0A0LBixJW3t
	YzDyWHI/gfjHX5dn/NL0Vo7npPLcmWCcM646tC2Osl7PxkdOR2ifhLx8cN7Gl19/y4kInNHgCsa
	Far2gpLyDB7TYeK45+t5MVEiDHinv2qo7hSy0
X-Received: by 2002:a05:6000:40d9:b0:437:70d3:44e7 with SMTP id
 ffacd0b85a97d-4395fd5674amr8175315f8f.30.1771555506943; Thu, 19 Feb 2026
 18:45:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216201428.65641-1-kohei@enjuk.jp>
In-Reply-To: <20260216201428.65641-1-kohei@enjuk.jp>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 19 Feb 2026 18:44:56 -0800
X-Gm-Features: AaiRm52M2ZhyERA5MfSVbNahK0U1WI9kgHu0DTPC7VUtQG0QZWXC2HYB6Mxd4gg
Message-ID: <CAADnVQL4F10BxRHp_-inKpHbDuZZ-aXsAOuLZL-k7aGaM0zBbA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf] bpf: devmap: fix stack-out-of-bounds write in get_upper_ifindexes()
To: Kohei Enju <kohei@enjuk.jp>
Cc: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jussi Maki <joamaki@gmail.com>, 
	kohei.enju@gmail.com, syzbot+10cc7f13760b31bd2e61@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259639-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,linux.dev,google.com,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,10cc7f13760b31bd2e61];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3D0D01644AC
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 12:15=E2=80=AFPM Kohei Enju <kohei@enjuk.jp> wrote:
>
> get_upper_ifindexes() iterates over all upper devices and writes their
> indices into an array without checking bounds.
>
> Also the callers assume that the max number of upper devices is
> MAX_NEST_DEV and allocate excluded_devices[1+MAX_NEST_DEV] on the stack,
> but that assumption is not correct and the number of upper devices could
> be larger than MAX_NEST_DEV (e.g., many macvlans), causing a
> stack-out-of-bounds write.
>
> Add a max parameter to get_upper_ifindexes() to avoid the issue.
>
> To reproduce, create more than MAX_NEST_DEV(8) macvlans on a device with
> an XDP program attached using BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS.
> Then send a packet to the device to trigger the XDP redirect path.
>
> Reported-by: syzbot+10cc7f13760b31bd2e61@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/698c4ce3.050a0220.340abe.000b.GAE@goo=
gle.com/T/
> Fixes: aeea1b86f936 ("bpf, devmap: Exclude XDP broadcast to master device=
")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
>  kernel/bpf/devmap.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index 2625601de76e..cdc4299a5955 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -588,16 +588,18 @@ static inline bool is_ifindex_excluded(int *exclude=
d, int num_excluded, int ifin
>  }
>
>  /* Get ifindex of each upper device. 'indexes' must be able to hold at
> - * least MAX_NEST_DEV elements.
> + * least 'max' elements.
>   * Returns the number of ifindexes added.
>   */
> -static int get_upper_ifindexes(struct net_device *dev, int *indexes)
> +static int get_upper_ifindexes(struct net_device *dev, int *indexes, int=
 max)
>  {
>         struct net_device *upper;
>         struct list_head *iter;
>         int n =3D 0;
>
>         netdev_for_each_upper_dev_rcu(dev, upper, iter) {
> +               if (n >=3D max)
> +                       break;
>                 indexes[n++] =3D upper->ifindex;
>         }
>         return n;
> @@ -615,7 +617,9 @@ int dev_map_enqueue_multi(struct xdp_frame *xdpf, str=
uct net_device *dev_rx,
>         int err;
>
>         if (exclude_ingress) {
> -               num_excluded =3D get_upper_ifindexes(dev_rx, excluded_dev=
ices);
> +               num_excluded =3D
> +                       get_upper_ifindexes(dev_rx, excluded_devices,
> +                                           ARRAY_SIZE(excluded_devices) =
- 1);

No need to reformat. 100 char is ok.

Jesper, Toke, pls review.

pw-bot: cr

