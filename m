Return-Path: <netdev+bounces-259742-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCZNMkmHmGnKJQMAu9opvQ
	(envelope-from <netdev+bounces-259742-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 17:09:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 090D816930B
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 17:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA9D430180A1
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 16:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6672DEA61;
	Fri, 20 Feb 2026 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="itukhgaO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7742D9EFF
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771603782; cv=pass; b=Bue0aXjcMm5vOG6Wlk/GXfDgGEJaYt8EzVvo96Mi3aQm+NrRCMaY7TDvKusNnsN5zlWEUzKmUzfU/6mvYGF0qCGsfFvUNVLZVEFsqFFqOzZY4ECxrZYJlUWsdYSwCcVKm5cCTtfjwuUpn2MbX/9RT8cqo4bpGCTd5Hw8bI6cZuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771603782; c=relaxed/simple;
	bh=CkESwBbR0rnloachcm4NmkXc/MqZEyj+IlOCJu/zwcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFtjDxokFkOb/j9VG07BvXLnd2FM2EDQR/t4nGx+3mVu+tVsdg4pJWivwoXaqjKspyt/sm5v4HhZjgMFDUc9GYyD2z6ffmxFRWLgQKsSGk1oC4m1QU74W7NGB3sa33Fff0YSVs28ketjxd3I/q1zvLuR0JUvZVJ9Y0xXKUvqy/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=itukhgaO; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64aedd812baso2067957d50.3
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 08:09:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771603780; cv=none;
        d=google.com; s=arc-20240605;
        b=UYh6miV0ACDgDJ8S2o8A8mZdjjacfJVQpaYSiFBGODkTrw/JiVJXTbv9HVl01MtnAv
         3TTV9Vh2Vp9Wj497rKuHwDikFZbvz08vDDZH5uEybTeR7mcOupZuahm1QOlZNjrn73Ie
         2IgHsar3tU67qo3zPm8sR7UHAlweFQPZioeff/XaoiZ9TqLk6afGq9KlhrEL/my4sjYm
         2+V6XH/f87iPpSmHYn61U0gx3UmH6I1Pw+vHmyUdxuH0pE+lxm78Sw6HCKoRtDH8Ds2b
         UcDbZ2K01EkJyjf6e6zHeYI1IdNZBzpoROWeylLvCf5eZe87DD3oOVBmdImrdpj3STLB
         cL/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SAdLzQJSZy6AcLPGK1Sc0B7gJ0DScQyLuGelN0a9WwE=;
        fh=ICiSP7Zs6fgK8lYrbGDb/gQcgG2TNCmQSaRIj9a5qoA=;
        b=YKP0e7C6E2uPkfAyMI5c02lsuIBzBuyLiUbl8RSakFhHqUtTeCtHKkdpyjqui0or4M
         cxUTSHLs3aALST5+k4O7YWT5R7RnKxrNDrxha5BcyzvLPmr7Sp+SozX7lY6z3rVBbXkE
         TEbRYP6IV7xzmqNlGU5lnbag1O/drKWicoiyEn9WapiMCC2xUFgXdz6Uqz7Ewhg8AUAW
         /v4UPPYnR3acqzaqpv+H6oWMb9M/SPsL6MRzwSV32PEFSH507z6kw1ecLjepOouow/Sp
         B1U2O0NDZIBvBW8IqVbAL9SUbUqDC1A4zVBr89XOzq4Sj7l/3UY4Ma0Dqfm0j4nucQYu
         6yvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1771603780; x=1772208580; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SAdLzQJSZy6AcLPGK1Sc0B7gJ0DScQyLuGelN0a9WwE=;
        b=itukhgaO2KCOMh8z79I9qIZPSDfr1iugOsyKQIwutw2RV805IbIuNb+9D9uyT1NRnk
         UK/AGs/DMtxaXDwCW6zA8m03mN3YkWrHhjaPr6Rxp5jsLvvplKcPAk9kGJDg/WuP8d/k
         XKo3V9nRwYc4TStU/dExLiREaEVWN01AOBF4krVZgg+zOPsul9t+uFHQqtWTj4ezXxaS
         7nTcDo1J9Z3qSoDJCT8OkUeQbzCyKOttv8fqwkMpGrA1koBWh9ElWSuENYjDAwmocqHf
         /bdczzDhIWMX7bMe4b59t/pfJFQKtiIJiN4v8u4jwJwu3ZbT5gM5tMzK4XtkisIWetV4
         KOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771603780; x=1772208580;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAdLzQJSZy6AcLPGK1Sc0B7gJ0DScQyLuGelN0a9WwE=;
        b=b5GCeati87g4OQzWL3C64jcyZ1OtT2feTMRYDjqdCA5UKRAy8TKdzatbj9MxgT/WeB
         vK7UlbPe2ZpF4xZ54eBXW2QLmu3j6WelGTC9aLyIRG0/8v/5cvyXDKJS0got9vk91+Vc
         UQwxySPm6zxJUB6FanQLaxTw8tpXG2L0SBbrk+uo49Yr20CICSceK1Mn3K03dL+jldDe
         FMkoe/1cTi/q/7cPGdmQzY870afhNbinimrporYkc6bnEk3dJLkMn592jgklKcWmU2I2
         ItXzjzAYaRBRSkEKgi50bpiPN7b8Hc+D/kMSsOz8incsstRhqxF3S+TpP7DXNaftVXpw
         vikQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqjHPglBCcwaa3hhOliohJ3m9uTDkqULInERzvG994lZqkNkq7eUoipuDSWavQji8VbdmXpTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzbWSLNtPnt4UOGhtF03TBajLvEt1ZdnMUKYHQgqy6nb0Il/qJ
	s7foSO27XgVLF/YuTzemzHrZfqxQnLrxW8KWtNk1sNKKM5N/U0PvDfDILrW04NVCsWZ8IQe3HUA
	TBA9gzOOiEn5HilS9Ed+FxEPjr5nsBC4UmNqkcVSB
X-Gm-Gg: AZuq6aIiQl7DSmL+C9p9o/FI1T3wPBfX1kamWQvkHKAcQlRyzquBr579lkc3lL7LbRG
	JpItvnXG6VNwrbRYosOi5kmrtpBEOH5cuGySF1kJFVdRkwliQDZQ1tGn2G9szkQ7oeemLM3rfbi
	k9H7zogOmUwLSg7EFgNkBmqwdpte91q3SOx4eTrpjEZhgaGwBoJBSxNrbojaCjjAiYkrpQRgzmK
	w6z/mx+MrokaODbPt8m/DeE7KQKwXexvSPPlDBpTzr9jKeoLcr1/9WawrDaZnAubYvYoc5G31x7
	bGY7Fpluk4aLx1dV+lloP/iA2RUc+lcI
X-Received: by 2002:a53:7701:0:b0:644:60d9:8649 with SMTP id
 956f58d0204a3-64c790a96b8mr135031d50.88.1771603779752; Fri, 20 Feb 2026
 08:09:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219023151.171753-1-p@1g4.org> <20260219023151.171753-2-p@1g4.org>
In-Reply-To: <20260219023151.171753-2-p@1g4.org>
From: Victor Nogueira <victor@mojatatu.com>
Date: Fri, 20 Feb 2026 13:09:28 -0300
X-Gm-Features: AZwV_QhyUehe-pEspw2ceXPuL8NPY47i2uBjfDAaUnsA15wcOWcjumMXOboVa8s
Message-ID: <CA+NMeC-WmxL48X5dSqGx5+2T_dR8B_g5C2BL2Hre_HG1-UkXDg@mail.gmail.com>
Subject: Re: [PATCH net v7 1/1] net/sched: act_gate: snapshot parameters with
 RCU on replace
To: Paul Moses <p@1g4.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259742-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 090D816930B
X-Rspamd-Action: no action

> The gate action can be replaced while the hrtimer callback or dump path is
> walking the schedule list.
>
> Convert the parameters to an RCU-protected snapshot and swap updates under
> tcf_lock, freeing the previous snapshot via call_rcu(). When REPLACE omits
> the entry list, preserve the existing schedule so the effective state is
> unchanged.
> [...]
> diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> index c1f75f2727576..917974b68c3fd 100644
> --- a/net/sched/act_gate.c
> +++ b/net/sched/act_gate.c
> [...]
> @@ -375,25 +472,26 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
> [...]
> +       if (need_cancel)
> +               hrtimer_cancel(&gact->hitimer);
> +
> +       spin_lock_bh(&gact->tcf_lock);
>
>         if (!cycletime) {
>                 struct tcfg_gate_entry *entry;
> @@ -404,20 +502,22 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
>                 cycletime = cycle;
>                 if (!cycletime) {
>                         err = -EINVAL;
> -                       goto chain_put;
> +                       goto unlock;
>                 }
> [...]

The AI says:

"If this error path is taken after hrtimer_cancel() was called above
(when need_cancel is true), does the timer get restarted with the old
parameters?

Looking at the unlock path:

unlock:
        spin_unlock_bh(&gact->tcf_lock);
err_free:
        release_entry_list(&p->entries);
        kfree(p);
chain_put:
        if (goto_ch)
                tcf_chain_put_by_act(goto_ch);
release_idr:
        if (ret == ACT_P_CREATED)
                gate_setup_timer(gact, timer_clockid, tko);
        tcf_idr_release(*a, bind);
        return err;

The gate_setup_timer() call at release_idr only runs for ACT_P_CREATED,
not for REPLACE operations. When a REPLACE operation changes
basetime/clockid/tk_offset (making need_cancel true), hrtimer_cancel()
is called. If the subsequent cycletime validation fails, this error path
never restarts the timer, leaving the gate action with a permanently
stopped hrtimer.

Should the error path restart the timer with the old parameters when
need_cancel was true?"

What it describes won't happen (at least from what I understand)
because your current code won't allow zero entries and the interval
parameter can't be 0. However it has a point because, if cycletime
can't be 0 anymore, you should remove this error path altogether.

cheers,
Victor

