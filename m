Return-Path: <netdev+bounces-262519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJYuID8opWla4wUAu9opvQ
	(envelope-from <netdev+bounces-262519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 07:03:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5E51D35BC
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 07:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1128A301DECE
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 06:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35D63806BB;
	Mon,  2 Mar 2026 06:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fV852mfP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB35377022
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 06:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772431397; cv=pass; b=qMMpHGaMa4zRlj9MngF4CfK+ZTZbnjhlitW4so+RaByP59lwAMlqzJO3yCXfiEo+5z9G7ukJnKKmmTJKfmTDkYFeu7peDuuBeqGEShGEf/KZSzWDz8zUhlKHy07bZPgxKFpSXDFtc206UBzQTzoo9WlhAh+jP020zjOLQgeQlYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772431397; c=relaxed/simple;
	bh=VoL9+Q5vKBh/stH6CbzLSnBWXCrGTyp5hmi39PUL9ZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fOoOdv3vR7h2XySg+ewE0/xLK4MRtGRrigeIYKtLt7h775dlpl1ogAIMtNkDjDzM98phYCFTrNIWKAiOqu6r8yQYPP/4GRBEGR9a/AAI/qEwCfzSBPks06k2OGVGN7N0H/Zkqu0y0BQp+1Vkk1tA77likM+BqQeNGVLc0oDPRLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fV852mfP; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50336cffef9so36701131cf.0
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 22:03:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772431388; cv=none;
        d=google.com; s=arc-20240605;
        b=cGT/857nShqjcPc6Wf0GIL0X2BA7QmM3D3TQDGEoZT7FACvaf+fh0gM9Vd40AUeGXR
         Fayr3ElBMJTJlr6birHwBRz8rN7jND09+aHyrz0ywkjQlt1cIhbItNJNL6CEfzNt6aE6
         2MJM9yJq9y9jvecjAcQgphncQAIOvyKihdljyR7gCiLF6oWzftBuR+nLya67ES+XYPaZ
         VEdfAakToei8aXbDvLia+7X8Q/fpPMLvFm5djroNxjwkno+KYQqlsFGZmbDDYVMLTCSu
         6vXzC7IeTE2V4TmayKJf2+G2fLv8O2jsR0gMtgh6Blj6hobg4ZHfqyEfzXNKYnpHjZem
         UXbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UjR2Jso0hAuDoeUEgb8RQHlOodoa5Tiq2cd7ca0LZWk=;
        fh=byS6zz0kO2UXjcJjvt6Y70eBR/P6748xxnRHf04cpfA=;
        b=d2rZyJWX7erVzUHu2yaieBNL8A/4CmdfoqtN3ZP+86LDaK2fR+JHgCDxMT0I4H3oq8
         BcjCNG6h/0SBStm5Ln7XzW9X4fvXLvK7F/F2o5SPiBQhPGxeeTT3N3uMbtd94RvpDiHU
         /49f+QA0c37RsO1B+8Vcju8Rq1CsAFUjx+RdVCqbKTHM6vwarL3ueEHBVnDMolD08Uq2
         RD4Nc+0eYt0dY+j2/Uk2JFa07DbeQ14aRAo0HhMaYPOQt8k1BD6io4NWg0WgeSQ1fYfm
         M2aPwsdaAGFu0vvScybXnZSWNYAMF+nDaUPJfJNyD0qeqGYv7hWciyedmRmCktrKorm8
         DOzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772431388; x=1773036188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjR2Jso0hAuDoeUEgb8RQHlOodoa5Tiq2cd7ca0LZWk=;
        b=fV852mfPlO1kd0tk8vuAlyOMCw3RgCcI90Ok33kFctyvy6yMj71hc/397JQ82Nx47r
         2CIksUAU71apTmyT2XrlGQ+S8XZN/WzAeCIoIf57K3PFap5iMFt+kmhE5AT1CIPefSOo
         u//W0d3sT3MIJNkZXFvJigPi4T6DoPqDLk/qluIfRSiaD3JR9XTQuH8g1bgMNOZObEDf
         xIRHnHgSupvAfansKxiAPVDSZnpG08YVrwcbjVhs3ftgeDYiDBFxn/qrX/F1W8pMuHup
         TM5Ea+de1N/pt5o1D56yUBovTBKRsq7YiE2Xt30W541KCCCtiGCeYBcuu3lo8Q8zJI3I
         mhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772431388; x=1773036188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UjR2Jso0hAuDoeUEgb8RQHlOodoa5Tiq2cd7ca0LZWk=;
        b=tEu3utbQ5zi9RFWbtT1+jVy2r4Cq9w39BEeCY6t37LTA1Xb0aovBO87FMHlz7XIhd7
         n4O5IClpoRO4xFTuSbyCcm46t2qheP7Dsp1xo+s9hJ6EnFxFKWmxSMLiCC436ZDZFx5V
         46+1Obei7o7DrciSkXepiMQGELvS4zPiVf58zN1/QXka7aJcWCS7WKaPbfqdMgf9orvO
         IdZULJqKnKQe5DAbjHR0l6HI99dxYvlF6ATkp/w1vIDc+wD9kPVlZEteScNbajhqEWoo
         bdU+ugLxQ72qmdb3KbPEGBA3z6xSkXfDgSajcqAQsJp4vrJRYKtojJTx8fXKt9HWJb8b
         uceA==
X-Forwarded-Encrypted: i=1; AJvYcCUwbw2l2fpWQjk3InlqToJIehMpnZwm81MOQj2bBiDPEBOp19nlexYFkVHBqrjO7MiENLOwFd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGf9ySa88qXuca1bBIWHT48msvmQ3U0140EYUwAa9d877AsH5X
	Bl+QT2Zz+jKuH+9LStwOiO2e8aw0K+mQY/rj6d25AyLo3thulRbEGGc7TLeHBxAAi6mXBETLDuX
	EUcqFoM/BD8oKQV6DhAhqm7YCmAUes6kVwEXjHWTb
X-Gm-Gg: ATEYQzzeuPMUtErXs/hPnDO4zxOwJ0j6FBsoZK4izf6KUpKF3MFlj+1xvMYA+bYSYMb
	UHd158X/bJnNWplNM1eeeGIgR/2M/qYw8V2pelQoGM8ojkEyA4bG0LwBgIeDNTUE20CkvIefeDj
	RLyzulC9BxFfYx3kgt+rWuBhcZZMYCJHqYHS2jE1g1X90uPum3mVQ7i3pWekMcgyrzpnOHIBp4K
	CS8x6vIj0UdksLjomZdzLVrmhQAJh+FZlEcK8YOxUhf1VpQdppEu4WmpFGOzASJ4asmw/dZPes9
	Ih8ww5I=
X-Received: by 2002:a05:622a:5ca:b0:4ee:bac:e3a9 with SMTP id
 d75a77b69052e-50752a0a185mr159644611cf.68.1772431387431; Sun, 01 Mar 2026
 22:03:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301181457.3539105-8-edumazet@google.com> <202603020743.NEL0agrx-lkp@intel.com>
In-Reply-To: <202603020743.NEL0agrx-lkp@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 2 Mar 2026 07:02:55 +0100
X-Gm-Features: AaiRm53wQGM3WwCV3bQMeh1Dn2GLN-C3-snKzACE_E-q2yOPyIOVSeKUAVhiYKE
Message-ID: <CANn89iLCXFOuMSrNQY27CfOwTfzUoVMkq1Zd+-O50YtCMSEmDw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 7/7] net-sysfs: use rps_tag_ptr and remove
 metadata from rps_dev_flow_table
To: kernel test robot <lkp@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,lists.linux.dev,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-262519-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,01.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE5E51D35BC
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 12:39=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Eric,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/net-a=
dd-rps_tag_ptr-type-and-helpers/20260302-021900
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20260301181457.3539105-8-edumaze=
t%40google.com
> patch subject: [PATCH v2 net-next 7/7] net-sysfs: use rps_tag_ptr and rem=
ove metadata from rps_dev_flow_table
> config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/202=
60302/202603020743.NEL0agrx-lkp@intel.com/config)
> compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009=
708b4367171ccdbf4b5905cb6a803753fe18)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20260302/202603020743.NEL0agrx-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202603020743.NEL0agrx-lkp=
@intel.com/

Yeah, in V3 I will remove the BITS_PER_LONG distinction, prone to
errors like this one.

 #if BITS_PER_LONG > 32
 ...
#else
  ...
#endif

