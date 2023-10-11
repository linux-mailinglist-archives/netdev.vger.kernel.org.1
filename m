Return-Path: <netdev+bounces-40030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9317C5783
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 16:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0070F1C20C0F
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 14:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299B91D69D;
	Wed, 11 Oct 2023 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56E11BDDA
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 14:56:02 +0000 (UTC)
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D895194
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 07:56:00 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:35168)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1qqacw-008FF8-GS; Wed, 11 Oct 2023 08:55:58 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:50886 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1qqacv-00BwWZ-Bd; Wed, 11 Oct 2023 08:55:58 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: David Ahern <dsahern@gmail.com>,  Stephen Hemminger
 <stephen@networkplumber.org>,  netdev@vger.kernel.org,  Nicolas Dichtel
 <nicolas.dichtel@6wind.com>,  Christian Brauner <brauner@kernel.org>,
  David Laight <David.Laight@ACULAB.COM>
References: <20231009182753.851551-1-toke@redhat.com>
	<877cnvtu37.fsf@email.froward.int.ebiederm.org>
	<87jzrvzc5v.fsf@toke.dk>
	<87ttqznxjm.fsf@email.froward.int.ebiederm.org>
	<878r8azjgd.fsf@toke.dk>
	<87y1gajne4.fsf@email.froward.int.ebiederm.org>
	<87r0m1xo97.fsf@toke.dk>
Date: Wed, 11 Oct 2023 09:55:08 -0500
In-Reply-To: <87r0m1xo97.fsf@toke.dk> ("Toke =?utf-8?Q?H=C3=B8iland-J?=
 =?utf-8?Q?=C3=B8rgensen=22's?= message of
	"Wed, 11 Oct 2023 15:49:40 +0200")
Message-ID: <871qe1i4z7.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1qqacv-00BwWZ-Bd;;;mid=<871qe1i4z7.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/7sAhaGnnAhnXjHY1ytpSJu0cTumbigC8=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAD_ENC_HEADER,BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: =?ISO-8859-1?Q?;Toke H=c3=b8iland-J=c3=b8rgensen <toke@redhat.com>?=
X-Spam-Relay-Country: 
X-Spam-Timing: total 530 ms - load_scoreonly_sql: 0.14 (0.0%),
	signal_user_changed: 11 (2.0%), b_tie_ro: 9 (1.7%), parse: 1.27 (0.2%),
	 extract_message_metadata: 15 (2.9%), get_uri_detail_list: 2.9 (0.6%),
	tests_pri_-2000: 13 (2.4%), tests_pri_-1000: 2.7 (0.5%),
	tests_pri_-950: 1.45 (0.3%), tests_pri_-900: 1.13 (0.2%),
	tests_pri_-200: 0.90 (0.2%), tests_pri_-100: 4.0 (0.8%),
	tests_pri_-90: 103 (19.4%), check_bayes: 97 (18.4%), b_tokenize: 11
	(2.1%), b_tok_get_all: 9 (1.7%), b_comp_prob: 3.6 (0.7%),
	b_tok_touch_all: 70 (13.2%), b_finish: 0.97 (0.2%), tests_pri_0: 362
	(68.3%), check_dkim_signature: 0.64 (0.1%), check_dkim_adsp: 2.5
	(0.5%), poll_dns_idle: 0.74 (0.1%), tests_pri_10: 2.2 (0.4%),
	tests_pri_500: 9 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH iproute2-next 0/5] Persisting of mount namespaces
 along with network namespaces
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>
>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>>
>>> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>>>
>>>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>>>>
>>>>> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>>>>>
>>>>>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

>> My proposal:
>>
>> On "ip netns add NAME"
>> - create the network namespace and mount it at /run/netns/NAME
>> - mount the appropriate sysfs at /run/netns-mounts/NAME/sys
>> - mount the appropriate bpffs at /run/netns-mounts/NAME/sys/fs/bpf
>>
>> On "ip netns delete NAME"
>> - umount --recursive /run/netns-mounts/NAME
>> - unlink /run/netns-mounts/NAME
>> - cleanup /run/netns/NAME as we do today.
>>
>> On "ip netns exec NAME"
>> - Walk through /run/netns-mounts/NAME like we do /etc/netns/NAME/
>>   and perform bind mounts.
>
> If we setup the full /sys hierarchy in /run/netns-mounts/NAME this
> basically becomes a single recursive bind mount, doesn't it?

Yes.

> What about if we also include bind mounts from the host namespace into
> that separate /sys instance? Will those be included into a recursive
> bind into /sys inside the mount-ns, or will we have to walk the tree and
> do separate bind mounts for each directory?

if /run/netns-mounts/NAME/sys has everything you want.

mount --rbind /run/netns-mounts/NAME/sys /sys

Will result in a /sys that has everything you want.

> Anyway, this scheme sounds like it'll solve the issue I was trying to
> address so I don't mind doing it this way. I'll try it out and respin
> the patch series.

Thanks that sounds like a way forward.


>>>> Mount propagation is a way to configure a mount namespace (before
>>>> creating a new one) that will cause mounts created in the first mount
>>>> namespace to be created in it's children, and cause mounts created in
>>>> the children to be created in the parent (depending on how things are
>>>> configured).
>>>>
>>>> It is not my favorite feature (it makes locking of mount namespaces
>>>> terrible) and it is probably too clever by half, unfortunately systemd
>>>> started enabling mount propagation by default, so we are stuck with it.
>>>
>>> Right. AFAICT the current iproute2 code explicitly tries to avoid that
>>> when creating a mountns (it does a 'mount --make-rslave /'); so you're
>>> saying we should change that?
>>
>> If it makes sense.
>>
>> I believe I added the 'mount --make-rslave /' because otherwise all
>> mount activity was propagating back, and making a mess.  Especially when
>> I was unmounting /sys.
>>
>> I am not a huge fan of mount propagation it has lots of surprising
>> little details that need to be set just right, to not cause problems.
>
> Ah, you were talking about propagation from inside the mountns to
> outside? Didn't catch that at first...
>
>> With my proposal above I think we could in some carefully chosen
>> places enable mount propagation without problem.
>
> One thing that comes to mind would be that if we create persistent /sys
> instances in /run/netns-mounts per the above, it would make sense for
> any modifications done inside the netns to be propagated back to the
> mount in /run; is this possible with a bind mount? Not sure I quite
> understand how propagation would work in this case (since it would be a
> separate (bind) mount point inside the namespace).

Basically yes, but the challenge is in the details.

If the initial propagation is setup properly it will work.  The
weirdness is how propagation works.  There is a weird detail that
it needs to be setup on the parent and not on the mount point.

I think the formula is something like:

mount --bind /run/netns-mounts/NAME/sys/ /run/netns-mounts/NAME/sys/
mount --make-rshared /run/netns-mounts/NAME/sys/
mount -t sysfs /run/netns-mounts/NAME/sys

My memory is that systemd by default does

mount --make-rshared /

So the challenge may be to simply limit what is propagated to a
controlled subset.

Eric

